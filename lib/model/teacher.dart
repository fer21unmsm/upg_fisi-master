class Teacher {
  int _id;
  String _name;
  String _grado;
  String _especialidad;

  Teacher(this._name,this._grado,this._especialidad);
  Teacher.withId(this._id,this._name,this._grado,this._especialidad);

  int get id => _id;
  String get name => _name;
  String get grado => _grado;
  String get especialidad => _especialidad;
  
  set name (String name) {    
      _name = name;
  }

  set grado (String grado) {    
      _grado = grado;
  }

  set especialidad (String especialidad) {
      _especialidad = especialidad;
  }
}
