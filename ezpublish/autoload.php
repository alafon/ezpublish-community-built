<?php
/**
 * File containing the autoload configuration.
 * It uses Composer autoloader and is greatly inspired by the Symfony standard distribution's.
 *
 * @copyright Copyright (C) 1999-2013 eZ Systems AS. All rights reserved.
 * @license http://ez.no/licenses/gnu_gpl GNU General Public License v2.0
 * @version 
 */

use Doctrine\Common\Annotations\AnnotationRegistry;

$loader = require __DIR__.'/../vendor/autoload.php';

// intl
if ( !function_exists( 'intl_get_error_code' ) )
{
    require_once __DIR__.'/../vendor/symfony/symfony/src/Symfony/Component/Locale/Resources/stubs/functions.php';
    $loader->add( '', __DIR__.'/../vendor/symfony/symfony/src/Symfony/Component/Locale/Resources/stubs' );
}

AnnotationRegistry::registerLoader( array( $loader, 'loadClass' ) );

return $loader;
