<?php


use League\Flysystem\ZipArchive\ZipArchiveAdapter as ZipAdapter;

require_once APPPATH.'modules/seller/factory/MockUpFactory.php';
require_once APPPATH.'/modules/seller/handlers/MockupsHandler.php';

class ImportHandler
{

    public function getMockups($file, $userId)
    {
        $extractDest = $this->creatExtractDestination($userId);
        $userExtractionDir = $this->creatUserExtractionDir($extractDest);
        $extractedContent = $this->extractMockups($file, $extractDest);
        /**
         * Now we creat a new mockup image for each product mockup type which are defined in import_seller.php config
         */
        foreach ($extractedContent as $design) {
            if ($design['type'] != "file") {
                continue;
            }

            if ($design['size'] / pow(1024, 2) > config_item("import_seller")["max_image_file_size"]) {
                throw new InvalidArgumentException("حجم فایل {$design['path']} بیشتر از حد مجاز است.", 422);
            }
            try {
                $result[$design['path']] = [
                    "files" => [$design],
                    "category_id" => null,
                    "path" => str_replace(PUBLICPATH, "/", $userExtractionDir->getPathPrefix())
                ];
            } catch (Throwable $e) {
                log_message("error", $e->getMessage()."\n".$e->getTraceAsString());
                throw new Exception($e->getMessage());
            }
        }
        return $result;
    }

    /**
     * Create mockups
     * @param  array  $file
     * @param $requestedMockupTypes
     * @param $userId
     * @return array
     * @throws \Exception
     */
    public function createMockUps(array $file, $requestedMockupTypes, $userId)
    {
        $extractDest = $this->creatExtractDestination($userId);
        $userExtractionDir = $this->creatUserExtractionDir($extractDest);
        $extractedContent = $this->extractMockups($file, $extractDest);
        /**
         * Now we creat a new mockup image for each product mockup type which are defined in import_seller.php config
         */
        foreach ($extractedContent as $design) {
            if ($design['type'] != "file") {
                continue;
            }
            try {
                $result = $this->createAllMockupsForSingleClipArt($userExtractionDir, $requestedMockupTypes, $design);
            } catch (Throwable $e) {
                log_message("error", $e->getMessage()."\n".$e->getTraceAsString());
                throw new Exception($e->getMessage());
            }
        }
        return $result;
    }

    /**
     * @param $userId
     * @return string
     */
    private function creatExtractDestination($userId)
    {
        return config_item("import_seller")["extract_prefix_dir"].'user-'.$userId;
    }

    /**
     * @param $extractDest
     * @return \League\Flysystem\Adapter\Local
     */
    private function creatUserExtractionDir($extractDest)
    {
        $userDir = new League\Flysystem\Adapter\Local($extractDest);
        $userDir->deleteDir("/");

        return $userDir;
    }

    /**
     * @param $file
     * @param $extractDest
     * @return array
     * @throws \Exception
     */
    private function extractMockups($file, $extractDest)
    {

        try {
            $filesystem = new ZipAdapter($file['tmp_name']);
            $numFiles = $filesystem->getArchive()->numFiles;
            $maxNumFilesAllowed = config_item("import_seller")["max_zip_file_numbers"];
            if ($numFiles > $maxNumFilesAllowed) {
                throw new Exception(
                    "فایل زیپ در هر بارگذاری باید شامل حداکثر $maxNumFilesAllowed فایل باشد",
                    //                    "Maximum {$maxNumFilesAllowed} file numbers exceeded in your zip file",
                    422
                );
            }

            $filesystem->getArchive()->extractTo($extractDest);
        } catch (Throwable $e) {
            log_exception($e);
            throw new Exception("Error extracting the file: ".$e->getMessage());
        }
        return $filesystem->listContents();

    }

    /**
     * Handling mockup making and saving for all the desired mockup types coming from the configs
     * @param $userDir
     * @param $requestedMockupTypes
     * @param $clipArt
     * @return mixed
     * @throws \Exception
     */
    private function createAllMockupsForSingleClipArt($userDir, $requestedMockupTypes, $clipArt)
    {
        $configs = config_item("import_seller");

        try {
            $mockupDir = new League\Flysystem\Adapter\Local($configs['mockup_prefix_dir']);
        } catch (Throwable $e) {
            log_message("error", $e->getMessage()."\n".$e->getTraceAsString());
            throw new Exception($e->getMessage());
        }

        $mockupFactory = new MockUpFactory();

        /**
         * all possible mockups reading from the import_handlers configs with active = true element
         */
        foreach ($configs["mockup_types"] as $name => $mockupConfigs) {
            if ($mockupConfigs["active"] == false || ! key_exists($name, $requestedMockupTypes)) {
                continue;
            }
            try {
                $mockupFactory->make(
                    $mockupDir,
                    $userDir,
                    $clipArt,
                    $mockupConfigs
                )->insert();
                $results[$mockupConfigs["trait"].$mockupConfigs["category_id"]] = [
                    "files" => $mockupFactory->getMockupOutputs(),
                    "category_id" => $mockupConfigs["category_id"],
                    "path" => str_replace(PUBLICPATH, "/", $mockupFactory->getMockupsDir())
                ];
            } catch (Throwable $e) {
                log_message("error", $e->getMessage()."\n".$e->getTraceAsString());
                throw new Exception($e->getMessage());
            }
        }
        return $results;
    }


    /**
     * @param $importData
     * @return bool
     * @throws \Exception
     */
    public function importProducts($importData)
    {
        try {
            foreach ($importData as $productValues) {

                $product = $this->saveNewProduct($productValues['values']);
                // assign the thematic categories to the created product instance
                if (count($productValues['thematic_categories'])) {
                    $product->thematicCategories()->sync($productValues['thematic_categories']);
                }
            }
            return true;
        } catch (Throwable $e) {
            log_exception($e);
            throw $e;
        }

    }

    /**
     * @param  array  $values
     * @return \Illuminate\Database\Eloquent\Builder|\Illuminate\Database\Eloquent\Model
     * @throws \Exception
     */
    private function saveNewProduct(array $values)
    {
        try {
            return Product::query()->forceCreate($values);
        } catch (Throwable $e) {
            throw $e;
        }
    }
}