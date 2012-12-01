package com.maiev.nbody;

import com.haxepunk.Engine;
import com.haxepunk.HXP;

/**
 * ...
 * @author maiev
 */

class Main extends Engine 
{
	public static inline var kClearColor:Int = 0x333333;
	public static inline var kProjectName:String = "NBodySimulation";

	function new()
	{
		super(Config.S_WIDTH, Config.S_HEIGHT, Config.FRAMERATE, false);	
	}
	
	override public function init()
	{
#if debug
	#if flash
		if (flash.system.Capabilities.isDebugger)
	#end
		{
			HXP.console.enable();
		}
#end
		HXP.screen.color = kClearColor;
		HXP.screen.scale = 1;
    HXP.world = new SolarSystem();
	}

	public static function main()
	{
		var app = new Main();
	}
}