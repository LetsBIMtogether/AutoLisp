# AG AutoLisps
A collection of AutoLISP routines (scripts) that add custom AutoCAD commands for efficient drafting and template management. Tools include room and door dimensioning, tag searching, text background masks, template layer creation, and more.

## Videos

- 🎥 [Loading and Auto-Loading AutoLisp Routines](https://www.youtube.com/watch?v=MFsBnHQIBGM)
- 🎥 [Automatic Room Dimensions](https://www.youtube.com/watch?v=dXaQ9mx0jZw )
- 🎥 [Find Tag, Room & Door Dimensions & Background Masks](https://www.youtube.com/watch?v=UrmG1CulYjQ)
- 🎥 [Create or Delete Up to 1,453 AIA/NCS Layers](https://www.youtube.com/watch?v=R6elUfTXCvA)
- 🎥 [Create a Layer Legend with Colors, Linestyles & Descriptions](https://www.youtube.com/watch?v=KJMM_aD1DBU)

## Files

- **AG_BGMasks_v8.LSP**
  - Add or remove background masks on selected MTEXT objects to enhance readability.
  - Commands: 
    - `BGA`
	  - Adds a background mask.
	- `BGR`
	  - Removes a background mask.
  - <img src="GitHub%20Images/AG_BGMasks_v8.gif" width="600"/>

- **AG_DoorDimensions_v8.LSP**
  - Pick door start/end points and select a text label position.
  - Command: `DRD`
  - <img src="GitHub%20Images/AG_DoorDimensions_v8.gif" width="600"/>

- **AG_FindTag_v8.LSP**
  - Input a tag to zoom to matching block attributes in the drawing.
  - Command: `FindTag`
  - <img src="GitHub%20Images/AG_FindTag_v8.gif" width="600"/>

- **AG_LayerColorLegend_v4.LSP**
  - Generates a visual color legend of all layers in the drawing. Pick a start point and the script places one row per layer, each with a line drawn on that layer (showing its true color) and a text element displaying the layer name, color number and color name, and layer description if one exists.
  - Command: `LayCL`
  - <img src="GitHub%20Images/AG_LayerColorLegend_v4.gif" width="600"/>

- **AG_LayersAIA_v5.LSP**
  - Create or delete up to 1,453 AIA/NCS v5 standard layers by discipline with defined names colors, linestyles and descriptions. Requires pasting 4 line styles from `AG_LayersAIA_v5_LineStyles.dwg` prior to running any of the create layer commands. [AIA CAD Layer Guidelines (Duke University)](https://facilities.duke.edu/sites/default/files/AIA%20CAD%20Layer%20Guidelines.pdf) and [AIA Standard.ctb](https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/How-to-set-up-AIA-Layer-Standards-in-AutoCAD-LT.html) were used as a reference.
  - Commands:
    - `LayAIAcreateAll`
      - Creates all AIA layers for every discipline
    - `LayAIAcreateOnly`
      - Creates layers for specified discipline codes (e.g. `A`, `MEP`, `AMEP`)
    - `LayAIAdeleteAll`
      - Deletes all AIA layers
    - `LayAIAdeleteOnly`
      - Deletes layers for specified discipline codes
   - <img src="GitHub%20Images/AG_LayersAIA_v5.gif" width="600"/>

- **AG_RoomDimensions_v9.LSP** & **AG_RoomDimensions_v8-Metric.LSP**
  - Command: `RMDM`
  - Select two diagonal room corners and a label point to place formatted dimension labels (imperial or metric).
  - <img src="GitHub%20Images/AG_RoomDimensions_v9.gif" width="600"/>

## License

Licensed under the [MIT License](LICENSE).
<br/>
<br/>

---

## Go to [www.LetsBIMtogether.com](https://letsbimtogether.com/ "www.LetsBIMtogether.com") for:

- AutoLisps routines for AutoCAD software

- Revit/CAD Tips & Tricks YouTube channel

- Plugins & scripts for Revit software

- Autodesk Appstore page

- LinkedIn

- GitHub

- Blog
