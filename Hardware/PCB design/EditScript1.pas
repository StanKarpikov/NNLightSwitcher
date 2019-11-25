Procedure CreateAViaObject;
Var
    Board : IPCB_Board;
    Via   : IPCB_Via;
    Track   : IPCB_Track;
    Iterator  : IPCB_BoardIterator;
    Xcur: TReal;
    Ycur: TReal;
Begin;
     // retrieve the current board's handle
    Board := PCBServer.GetCurrentPCBBoard;
    If Board = Nil Then
    Begin;
         ShowMessage('Cant find the board!');
         Exit;
    End;

   //------------ Iterate VIA --------------------------------
   {// retrieve the iterator handle
   Iterator        := Board.BoardIterator_Create;
   Iterator.AddFilter_ObjectSet(MkSet(eViaObject));
   Iterator.AddFilter_LayerSet(AllLayers);
   Iterator.AddFilter_Method(eProcessAll);

    // search and count vias
    Via := Iterator.FirstPCBObject;
    While (Via <> Nil) Do
    Begin;
    //ShowMessage('Via X:' + RealUnitToString(CoordToMils(Via.X),eMil) +' Y:'+ RealUnitToString(CoordToMils(Via.Y),eMil));
      Xcur := CoordToMils(Via.X);
      Ycur := CoordToMils(Via.Y);
      Via.X :=  MilsToCoord(Round(Xcur));
      Via.Y :=  MilsToCoord(Round(Ycur));

      Via := Iterator.NextPCBObject;
    End;
    Board.BoardIterator_Destroy(Iterator);
    }
    //------------ Iterate Track --------------------------------
    // retrieve the iterator handle
    Iterator        := Board.BoardIterator_Create;
    Iterator.AddFilter_ObjectSet(MkSet(eTrackObject));
    Iterator.AddFilter_LayerSet(AllLayers);
    Iterator.AddFilter_Method(eProcessAll);

    // search and count vias
    Track := Iterator.FirstPCBObject;
    While (Track <> Nil) Do
    Begin;
      Track.X1 :=  MilsToCoord(Round(CoordToMils(Track.X1)));
      Track.Y1 :=  MilsToCoord(Round(CoordToMils(Track.Y1)));

      Track.X2 :=  MilsToCoord(Round(CoordToMils(Track.X2)));
      Track.Y2 :=  MilsToCoord(Round(CoordToMils(Track.Y2)));

      Track := Iterator.NextPCBObject;
    End;
    Board.BoardIterator_Destroy(Iterator);
End;

