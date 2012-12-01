package com.maiev.nbody;

import com.haxepunk.World;
import com.haxepunk.HXP;

/**
 * ...
 * @author maiev
 * code adapted from http://astro.berkeley.edu/~dperley/programs/ssms.html
 */

class SolarSystem extends World {
  
  // sun, 8 planets
  private var nump:Int = 10;
  
  // 10 elements because originally going to add another object
  public static var xCoor:Array<Float> =  [0,0,0,0,0,0,0,0,0,0];
  public static var yCoor:Array<Float> =  [0,0,0,0,0,0,0,0,0,0];
  public static var zCoor:Array<Float> =  [0,0,0,0,0,0,0,0,0,0];
  public static var xVel:Array<Float> =   [0,0,0,0,0,0,0,0,0,0];
  public static var yVel:Array<Float> =   [0,0,0,0,0,0,0,0,0,0];
  public static var zVel:Array<Float> =   [0,0,0,0,0,0,0,0,0,0];
  public static var xAccel:Array<Float> = [0,0,0,0,0,0,0,0,0,0];
  public static var yAccel:Array<Float> = [0,0,0,0,0,0,0,0,0,0];
  public static var zAccel:Array<Float> = [0,0,0,0,0,0,0,0,0,0];
  public static var mass:Array<Float> =   [0,0,0,0,0,0,0,0,0,0];
  
  public static var celestEnt:Array<CelestEntity> = new Array<CelestEntity>();
  
  public static inline var G:Float = 0.000667;

  public function new() {
    super();
    
    xCoor[1] = 0;   yCoor[1] = 0;  xVel[1] = 0; yVel[1] = -0.00000015; mass[1] = 19.89; //sun
    xCoor[2] = xCoor[1] - 5.7;    mass[2] = 0.00000330; //mercury
    xCoor[3] = xCoor[1] - 10.8;   mass[3] = 0.0000487; //venus
    xCoor[4] = xCoor[1] + 14.9;   mass[4] = 0.00005974; //earth
    xCoor[5] = xCoor[1] + 22.8;   mass[5] = 0.00000642; //mars
    xCoor[6] = xCoor[1] - 77.8;   mass[6] = 0.01899; //jupiter
    xCoor[7] = xCoor[1] + 142.4;  mass[7] = 0.00568; //saturn
    xCoor[8] = xCoor[1] + 287.2;  mass[8] = 0.000866; //uranus
    xCoor[9] = xCoor[1] + 449.9;  mass[9] = 0.00103; //neptune
    
    for (n in 2...nump) {
      xVel[n] = 0; yCoor[n] = 0;
      yVel[n] = (Math.sqrt(G * mass[1] / Math.abs(xCoor[n] - xCoor[1])));
      if (xCoor[n] > xCoor[1]) {
        yVel[n] = -1*yVel[n];
      }
      
      zCoor[n] = 0;
      zVel[n] = 0;
    }
    
  }
  
  public override function begin() {
    super.begin();
    HXP.camera.x =  -(Config.S_WIDTH / 2);
    HXP.camera.y =  -(Config.S_HEIGHT / 2);
    
    for (n in 1...nump) {
      var tempEnt:CelestEntity;
      tempEnt = new CelestEntity(xCoor[n], yCoor[n], this);
      celestEnt.push(tempEnt);
      add(tempEnt);
    }
  }
  
  public override function update() {
    super.update();
    
    // speed of simulation
    for (i in 0...5) {
      calculatePos();
    }
    
    for (i in 0...nump-1) {
      celestEnt[i].update();
    }
  }
  
  private function calculatePos() {
    var dx:Float = 0;
    var dy:Float = 0;
    var dz:Float = 0;
    var D:Float = 0;
    var A:Float = 0;
    
    for (n in 1...nump) {
      xAccel[n] = 0;
      yAccel[n] = 0;
      zAccel[n] = 0;
      for (i in 1...nump) {
        if (n != i) {
          dx = xCoor[i] - xCoor[n];
          dy = yCoor[i] - yCoor[n];
          dz = zCoor[i] - zCoor[n];
          D = Math.sqrt((dx * dx) + (dy * dy) + (dz * dz));
          A = (G * mass[i]) / (D * D);
          xAccel[n] += dx * A / D;
          yAccel[n] += dy * A / D;
          zAccel[n] += dz * A / D;
        }
        
      }
    }
    
    for (i in 1...nump) {
      xVel[i] += xAccel[i];
      yVel[i] += yAccel[i];
      zVel[i] += zAccel[i];
      
      xCoor[i] += xVel[i];
      yCoor[i] += yVel[i];
      zCoor[i] += zVel[i];
    }
  }
}