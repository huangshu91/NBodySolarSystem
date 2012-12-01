package com.maiev.nbody;

import com.haxepunk.World;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

/**
 * ...
 * @author maiev
 */

class CelestEntity extends Entity{

  public static var index:Int = 1;
  
  public var myId:Int;
  
  private var parent:SolarSystem;
  
  // for now use a static body size, maybe use realistic sizes in future
  public var bodySize:Int = 6;
  // for now use assigned color but maybe change in future
  public var color:Int = 0xFFFFFF;
  
  public function new(x:Float, y:Float, own:SolarSystem) {
    super(x - bodySize, y - bodySize);
    parent = own;
    myId = index++;
    if (myId != 1) 
    graphic = Image.createCircle(bodySize, color);
    
    else graphic = Image.createCircle(10, 0x00FF00);
    this.moveTo(x - bodySize, y - bodySize);
  }
  
  public override function update() {
    super.update();
    this.moveTo(SolarSystem.xCoor[myId] - bodySize, SolarSystem.yCoor[myId] - bodySize);
  }
}