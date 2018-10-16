<?php
namespace qrcode;

use Endroid\QrCode\QrCode;
use Endroid\QrCode\ErrorCorrectionLevel;
use Endroid\QrCode\LabelAlignment;

class GenerateQr
{
    public static function getCode($str,$center_img='',$show_code='',$size=300)
    {
        $qrCode = new QrCode($str);
        $qrCode->setSize($size);

// Set advanced options
        $qrCode
            ->setWriterByName('png')
            ->setMargin(10)
            ->setEncoding('UTF-8')
            ->setErrorCorrectionLevel(ErrorCorrectionLevel::HIGH)
            ->setForegroundColor(['r' => 0, 'g' => 0, 'b' => 0])
            ->setBackgroundColor(['r' => 255, 'g' => 255, 'b' => 255])
//            ->setLabel('Scan the code', 16, \ENV::get('vendor_path').'endroid/qr-code/assets/noto_sans.otf', LabelAlignment::CENTER)
//            ->setLogoPath(\ENV::get('vendor_path').'endroid/qr-code/assets/symfony.png')
            ->setLogoWidth(100)
            ->setValidateResult(false)
        ;

        //显示图片

        if($center_img) {
            try{

                if(strpos($center_img,'http://')!==false || strpos($center_img,'https://')!==false) {
                    $save_path = \ENV::get('root_path').'public'.'/images/header/down/'.md5($center_img).'.png';
                    if(!file_exists($save_path)){
                        file_put_contents(\ENV::get('root_path').'public'.'/images/header/down/'.md5($center_img).'.png',file_get_contents($center_img));
                    }

                    $qrCode->setLogoPath($save_path);
                }else{

                    $qrCode->setLogoPath(\ENV::get('root_path').'public'.$center_img);

                }
            }catch (\Exception $e) {

            }
        }

        //显示汉字
        if($show_code) {
            $qrCode->setLabel($show_code, 16, \ENV::get('vendor_path').'endroid/qr-code/assets/noto_sans.otf', LabelAlignment::CENTER);
        }
//        header();
//        return $qrCode->get
        return $qrCode->writeDataUri();

    }
}