<?php

use Intervention\Image\ImageManagerStatic as Image;

require_once APPPATH.'modules/seller/interfaces/MockUpInterface.php';

/**
 * Parent class for mockup classes for different type of products
 * Class MockupsHandler
 */
class MockupsHandler implements MockUpInterface
{

    const REFINEMENT_Y_CAT_IDS = [285, 231, 195];

    public $userDir = null;

    /**
     * @var null base mockup file
     */
    public $mockup = null;

    /**
     * @var null the array of raw data of the clip art file
     */
    public $clipArt = null;

    /**
     * @var null Processed clip art after resizing and making through Image class
     */
    public $clipArtOutput = null;
    /**
     * @var array special configs for the handler
     */
    public $config = [];
    /**
     * @var \League\Flysystem\Adapter\Local
     */
    public $mockupOutputDir;

    public function __construct()
    {
    }

    /**
     * @param  \League\Flysystem\Adapter\Local  $mockupDir
     * @param  \League\Flysystem\Adapter\Local  $userDir
     * @param  array  $clipArt
     * @param $configs
     * @return $this
     * @throws \Exception
     */
    public function make($mockupDir, $userDir, $clipArt, $configs)
    {
        $this->userDir = $userDir;
        $this->mockupOutputDir = new League\Flysystem\Adapter\Local(
            $this->userDir->applyPathPrefix("/mockup-outputs/{$configs['trait']}-{$configs['category_id']}")
        );
        $this->clipArt = $clipArt;
        $this->config = $configs;


        try {
            $this->clipArtOutput = Image::make($userDir->applyPathPrefix($clipArt['path']))->widen($configs["clip_art_size"]['width']);
            $this->mockup = Image::make($mockupDir->applyPathPrefix($configs["mockup_file_name"]));
        } catch (Throwable $e) {
            log_message("error", $e->getMessage()."\n".$e->getTraceAsString());
            throw new Exception($e->getMessage());
        }


        return $this;
    }

    /**
     *
     * @throws \Exception
     */
    public function insert()
    {
        try {
            $this->mockup->insert(
                $this->clipArtOutput,
                "top-left",
                $this->config["clip_art_position"]['x'],
                $this->positionRefinementY()
            );
        } catch (Throwable $e) {
            log_message("error", "Error mockup insertion: ".$e->getMessage());
            throw new Exception("Error mockup insertion: ".$e->getMessage());
        }

        try {
            return $this->mockup->save(
                $this->mockupOutputDir->applyPathPrefix($this->clipArt['path']),
                100,
                config_item("import_seller")["mockup_output_format"]
            );
        } catch (Throwable $e) {
            log_message("error", "Error saving mockup: ".$e->getMessage());
            throw new Exception("Error saving mockup: ".$e->getMessage());
        }
    }

    public function getMockupOutputs()
    {
        return $this->mockupOutputDir->listContents();
    }

    public function getMockupsDir()
    {
        return $this->mockupOutputDir->getPathPrefix();
    }

    /**
     * @param $sourcePath
     * @param  null  $destFile
     * @return \Intervention\Image\Image
     * @throws \Exception
     */
    public function createThumbnail($sourcePath, $destFile = null)
    {
        $destFile = $destFile ? $destFile : time().".jpg";
        try {
            $thumbPath = config_item("import_seller")["thumbnail_prefix_dir"];
            $format = config_item("import_seller")["mockup_output_format"];

            // creating thumbnail
            return Image::make($sourcePath)->resize(230, 253)
                ->save($thumbPath.$destFile, config_item("import_seller")["mockup_thumbnail_quality"], $format);
        } catch (Throwable $e) {
            log_message("error", "Error creating thumbnail: ".$e->getMessage());
            throw new Exception($e->getMessage());
        }

    }


    /**
     * Create a file name for mockups based on import post data
     * @param  array  $productData
     * @return string
     * @throws \Exception
     */
    public function createFileName(array $productData)
    {

        if ( ! key_exists("pic", $productData) || ! key_exists("category_id", $productData)) {
            log_message("error", "invalid arguments for creating file name");
            throw new Exception("Invalid Arguments", 400);
        }
        try {
            $mockupExplode = explode("/", $productData["pic"]);
            $mockupTrait = $mockupExplode[count($mockupExplode) - 2];
            $mockupFile = end($mockupExplode);
            return time()."_{$mockupTrait}_{$mockupFile}";
        } catch (Throwable $e) {
            throw $e;
        }
    }

    /**
     * @return int|mixed
     */
    private function positionRefinementY()
    {
        $positionY = $this->config["clip_art_position"]['y'];
        if ($this->clipArtOutput->getHeight() < ($this->clipArtOutput->getWidth() / 1.73)
            && in_array($this->config['category_id'], self::REFINEMENT_Y_CAT_IDS)) {
            $positionY += 35;
        }
        if ($this->clipArtOutput->getWidth() == $this->clipArtOutput->getHeight()
            && in_array($this->config['category_id'], self::REFINEMENT_Y_CAT_IDS)) {
            $positionY -= 50;
        }
        if ($this->clipArtOutput->getHeight() > 1.25 * $this->clipArtOutput->getWidth()
                && in_array($this->config['category_id'], self::REFINEMENT_Y_CAT_IDS)) {
            $positionY -= 40;
        }
        return $positionY;
    }
}