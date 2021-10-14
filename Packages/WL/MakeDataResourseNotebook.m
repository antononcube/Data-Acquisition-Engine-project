(* Mathematica Source File *)
(* Created by the Wolfram Language Plugin for IntelliJ, see http://wlplugin.halirutan.de/ *)
(* :Author: Anton Antonov *)
(* :Date: 2021-10-14 *)

Clear[MakeDataResourceNotebook];

MakeDataResourceNotebook[
  funcName_String,
  daDataObject_,
  description_String : "Place data resource description here!",
  subTitle_String : "Data resource notebook",
  idSuffixArg_ : Automatic,
  dirNameArg_String : Automatic ] :=
    Block[{repositoryNotebook, dirName = dirNameArg, idSuffix = idSuffixArg, fileName},

      repositoryNotebook = CreateNotebook["FunctionResource"];

      SelectionMove[repositoryNotebook, Before, Notebook];
      NotebookFind[repositoryNotebook, "Name", Next, CellTags];
      SelectionMove[repositoryNotebook, All, CellContents];
      NotebookWrite[repositoryNotebook, funcName];

      SelectionMove[repositoryNotebook, Next, Cell];
      SelectionMove[repositoryNotebook, All, CellContents];
      NotebookWrite[repositoryNotebook, subTitle];

      SelectionMove[repositoryNotebook, Before, Notebook];
      NotebookFind[repositoryNotebook, "Usage", Next, CellTags];
      SelectionMove[repositoryNotebook, Next, Cell];
      SelectionMove[repositoryNotebook, All, CellContents];
      NotebookWrite[repositoryNotebook, funcName <> "[\"Data\"]"];
      SelectionMove[repositoryNotebook, Next, Cell];
      NotebookWrite[repositoryNotebook, Cell["gets the data", "Text"]];

      SelectionMove[repositoryNotebook, Before, Notebook];
      NotebookFind[repositoryNotebook, "Details & Options", Next, CellTags];
      SelectionMove[repositoryNotebook, Next, Cell];
      SelectionMove[repositoryNotebook, All, CellContents];
      NotebookWrite[repositoryNotebook, description];

      SelectionMove[repositoryNotebook, Before, Notebook];
      NotebookFind[repositoryNotebook, "Definition", Next, CellTags];
      SelectionMove[repositoryNotebook, Next, Cell];
      SelectionMove[repositoryNotebook, All, CellContents];
      With[{data0 = daDataObject, head = ToExpression[funcName]},
        NotebookWrite[repositoryNotebook, MakeBoxes[head["Data"] := data0]]
      ];

      SelectionMove[repositoryNotebook, Before, Notebook];
      NotebookFind[repositoryNotebook, "Examples", Next, CellTags];
      SelectionMove[repositoryNotebook, Next, Cell];
      SelectionMove[repositoryNotebook, Next, Cell];
      NotebookWrite[repositoryNotebook, Cell["Get the data with:", "Text"]];
      SelectionMove[repositoryNotebook, Next, Cell];
      With[{head = ToExpression[funcName]},
        NotebookWrite[repositoryNotebook, MakeBoxes[head["Data"]]]
      ];

      NotebookEvaluate[repositoryNotebook];

      Which[
        TrueQ[dirName === Automatic ],
        dirName = NotebookDirectory[],

        !StringQ[dirName],
        dirName = NotebookDirectory[]
      ];

      If[
        TrueQ[idSuffix === Automatic ],
        idSuffix = ToString[RandomInteger[{100000, 999999}]]
      ];

      fileName = FileNameJoin[{ dirName, funcName <> idSuffix <> ".nb"}];

      NotebookSave[repositoryNotebook, fileName];

      fileName
    ];