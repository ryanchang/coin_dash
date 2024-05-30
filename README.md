# Coin Dash
This is the code repository for "Coin Dash" project from chapter 2 of [Godot Engine Game Development Projects](https://www.packtpub.com/game-development/godot-game-engine-projects?utm_source=github&utm_medium=repository&utm_campaign=9781788831505), published by Packt.
This project is adapted for Godot 4, and also added touchscreen virtual joystick support for mobile devices.

## Export iOS project for active development
1. Export coin_dash Godot project to coin_dash_ios as an iOS project.
2. Open coin_dash_ios with XCode.
3. In Finder, drag the Godot project folder into the Xcode file browser:  
   ![image](https://github.com/ryanchang/coin_dash/assets/363083/36bfcd45-da1d-405e-80b4-1d7108e8acb4)  
   make sure Create folder references is selected.

4. Delete coin_dash_ios.pck from the XCode project.  
   ![image](https://github.com/ryanchang/coin_dash/assets/363083/d8c38ee4-cdcd-4ea8-b4ef-66293268d910)  
   
5. Open coin_dash_ios-Info.plist and add a string property named "godot_path" with value "coin_dash":  
   ![image](https://github.com/ryanchang/coin_dash/assets/363083/5a275670-0c4b-4a2f-b245-f8ae766ebf1e)  
   
That's it! You can now edit your project in the Godot editor and build it in Xcode when you want to run it on a device.  
Checkout [Exporting for iOS](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_ios.html) for more details.

   

