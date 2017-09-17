<?php

namespace tests;

use PHPUnit\Framework\TestCase;
use bka\Greeting;
require_once 'src/Greeting.php';


/**
 * Greeting test case.
 */
 final class GreetingTest extends TestCase
{

    
    /**
     * @covers bka\Greeting::sayHello
     */
    public function testCanBeUsedAsString()
    
    {
        $greeting = new Greeting;
        $this->assertEquals("Hello world",$greeting->sayHello());
    }
    
}

