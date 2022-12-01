<?php


interface MockUpInterface
{

    public function insert();

    public function make(
        League\Flysystem\Adapter\Local $mockupDir,
        League\Flysystem\Adapter\Local $userDir,
        array $clipArt,
        $configs
    );

    public function createThumbnail($sourcePath, $destFile = null);
}