<?php

$config["import_seller"] = [
    /**
     * Extract destination for the user's uploaded file - fill with a real directory
     */
    "extract_prefix_dir" => PUBLICPATH.'upload/import/arts'.DIRECTORY_SEPARATOR,
    /**
     * Directory of raw mock-up images
     */
    "mockup_prefix_dir" => PUBLICPATH.'upload/import/mockups'.DIRECTORY_SEPARATOR,
    /**
     * Directory of raw mock-up images
     */
    "thumbnail_prefix_dir" => PUBLICPATH.'upload/products/pic/thumbnails'.DIRECTORY_SEPARATOR,
    /**
     * Thumbnail quality in percentage
     */
    "mockup_thumbnail_quality" => 100,
    /**
     * Directory of raw mock-up images
     */
    "product_pic_prefix_dir" => PUBLICPATH.'upload/products/pic'.DIRECTORY_SEPARATOR,
    /**
     * max_zip_file_numbers
     */
    "max_zip_file_numbers" => 50,
    /**
     * max_image_file_size in MB
     */
    "max_image_file_size" => 2,

    /**
     * Specify the final format of the mock-up output
     */
    "mockup_output_format" => "jpg",
    /**
     * handler class that implements the mockup creation
     */
    "handler_class" => "MockupsHandler",
    /**
     * Import handlers configs for different types of products
     */
    "mockup_types" => [
        "black_t_shirt" => [
            "active" => true,
            "trait" => "black",
            "label" => "تیشرت مشکی",
            "category_id" => 187,
            "mockup_file_name" => "/Black-T-shirt.jpg",
            /**
             * New size of the user's clip arts after insertion on the mock-up image
             */
            "clip_art_size" => ["width" => 115, "height" => 82],
            /**
             * Position of clip art
             */
            "clip_art_position" => ["x" => 170, "y" => 120],
        ],
        "blue_t_shirt" => [
            "active" => true,
            "trait" => "blue",
            "label" => "تیشرت آبی",
            "category_id" => 187,
            "mockup_file_name" => "/Blue-T-shirt.jpg",
            /**
             * New size of the user's clip arts after insertion on the mock-up image
             */
            "clip_art_size" => ["width" => 115, "height" => 82],
            /**
             * Position of clip art
             */
            "clip_art_position" => ["x" => 170, "y" => 120],
        ],
        "red_t_shirt" => [
            "active" => true,
            "trait" => "red",
            "label" => "تیشرت قرمز",
            "category_id" => 187,
            "mockup_file_name" => "/Red-T-shirt.jpg",
            /**
             * New size of the user's clip arts after insertion on the mock-up image
             */
            "clip_art_size" => ["width" => 115, "height" => 82],
            /**
             * Position of clip art
             */
            "clip_art_position" => ["x" => 170, "y" => 120],
        ],
        "yellow_t_shirt" => [
            "active" => true,
            "trait" => "yellow",
            "label" => "تیشرت زرد",
            "category_id" => 187,
            "mockup_file_name" => "/Yellow-T-shirt.jpg",
            /**
             * New size of the user's clip arts after insertion on the mock-up image
             */
            "clip_art_size" => ["width" => 115, "height" => 82],
            /**
             * Position of clip art
             */
            "clip_art_position" => ["x" => 170, "y" => 120],
        ],
        "white_t_shirt" => [
            "active" => true,
            "trait" => "white",
            "label" => "تیشرت سفید",
            "category_id" => 187,
            "mockup_file_name" => "/White-T-shirt.jpg",
            /**
             * New size of the user's clip arts after insertion on the mock-up image
             */
            "clip_art_size" => ["width" => 115, "height" => 82],
            /**
             * Position of clip art
             */
            "clip_art_position" => ["x" => 170, "y" => 120],
        ],
        "span_t_shirt" => [
            "active" => true,
            "trait" => "white",
            "label" => "تیشرت اسپان",
            "category_id" => 186,
            "mockup_file_name" => "/Span-T-shirt.jpg",
            /**
             * New size of the user's clip arts after insertion on the mock-up image
             */
            "clip_art_size" => ["width" => 115, "height" => 82],
            /**
             * Position of clip art
             */
            "clip_art_position" => ["x" => 170, "y" => 120],
        ],
        "melanj_t_shirt" => [
            "active" => true,
            "trait" => "melanj",
            "label" => "تیشرت ملانژ طوسی",
            "category_id" => 188,
            "mockup_file_name" => "/Melanj T-shirt.jpg",
            /**
             * New size of the user's clip arts after insertion on the mock-up image
             */
            "clip_art_size" => ["width" => 115, "height" => 82],
            /**
             * Position of clip art
             */
            "clip_art_position" => ["x" => 170, "y" => 120],
        ],
        "hodi" => [
            "active" => true,
            "trait" => "black",
            "label" => "هودی مشکی",
            "category_id" => 192,
            "mockup_file_name" => "/Hodi.jpg",
            /**
             * New size of the user's clip arts after insertion on the mock-up image
             */
            "clip_art_size" => ["width" => 115, "height" => 82],
            /**
             * Position of clip art
             */
            "clip_art_position" => ["x" => 175, "y" => 170],
        ],
        "red_hodi" => [
            "active" => true,
            "trait" => "red",
            "label" => "هودی قرمز",
            "category_id" => 192,
            "mockup_file_name" => "/Red-Hodi.jpg",
            /**
             * New size of the user's clip arts after insertion on the mock-up image
             */
            "clip_art_size" => ["width" => 115, "height" => 82],
            /**
             * Position of clip art
             */
            "clip_art_position" => ["x" => 175, "y" => 170],
        ],
        "melanj_gray_hodi" => [
            "active" => true,
            "trait" => "gray",
            "label" => "هودی ملانژ",
            "category_id" => 191,
            "mockup_file_name" => "/White-Hodi.jpg",
            /**
             * New size of the user's clip arts after insertion on the mock-up image
             */
            "clip_art_size" => ["width" => 115, "height" => 82],
            /**
             * Position of clip art
             */
            "clip_art_position" => ["x" => 175, "y" => 170],
        ],
        "pol" => [
            "active" => true,
            "trait" => "black",
            "label" => "پولیور مشکی",
            "category_id" => 193,
            "mockup_file_name" => "/Pol.jpg",
            /**
             * New size of the user's clip arts after insertion on the mock-up image
             */
            "clip_art_size" => ["width" => 115, "height" => 82],
            /**
             * Position of clip art
             */
            "clip_art_position" => ["x" => 175, "y" => 170],
        ],
        "white_pol" => [
            "active" => true,
            "trait" => "white",
            "label" => "پولیور سفید",
            "category_id" => 193,
            "mockup_file_name" => "/White-Pol.jpg",
            /**
             * New size of the user's clip arts after insertion on the mock-up image
             */
            "clip_art_size" => ["width" => 115, "height" => 82],
            /**
             * Position of clip art
             */
            "clip_art_position" => ["x" => 170, "y" => 170],
        ],
        "cushion" => [
            "active" => true,
            "trait" => "cream",
            "label" => "کوسن",
            "category_id" => 285,
            "mockup_file_name" => "/Cushion.jpg",
            /**
             * New size of the user's clip arts after insertion on the mock-up image
             */
            "clip_art_size" => ["width" => 260, "height" => 100],
            /**
             * Position of clip art
             */
            "clip_art_position" => ["x" => 105, "y" => 140],
        ],
        "buttons" => [
            "active" => true,
            "trait" => "pixel",
            "label" => "پیکسل",
            "category_id" => 231,
            "mockup_file_name" => "/Button.jpg",
            /**
             * New size of the user's clip arts after insertion on the mock-up image
             */
            "clip_art_size" => ["width" => 165, "height" => 105],
            /**
             * Position of clip art
             */
            "clip_art_position" => ["x" => 90, "y" => 135],
        ],
        "mug" => [
            "active" => true,
            "trait" => "white",
            "label" => "ماگ سرامیکی ساده",
            "category_id" => 195,
            "mockup_file_name" => "/Mug1.jpg",
            /**
             * New size of the user's clip arts after insertion on the mock-up image
             */
            "clip_art_size" => ["width" => 180, "height" => 160],
            /**
             * Position of clip art
             */
            "clip_art_position" => ["x" => 58, "y" => 178],
        ],
        "hat" => [
            "active" => 0,
            "trait" => "cotton",
            "label" => "کلاه",
            "category_id" => 223,
            "mockup_file_name" => "/Hat.jpg",
            /**
             * New size of the user's clip arts after insertion on the mock-up image
             */
            "clip_art_size" => ["width" => 170, "height" => 115],
            /**
             * Position of clip art
             */
            "clip_art_position" => ["x" => 95, "y" => 40],
        ],
    ],
];