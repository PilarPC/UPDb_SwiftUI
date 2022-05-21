//
//  ContentView.swift
//  Shared
//
//  Created by Profesor Flex on 26/04/22.
//

import SwiftUI
import Combine

//----------Conxión backEnd-------------------

struct Status:Decodable{
    var success:String
}
struct PeliculaOSerie:Decodable, Encodable{
    var nombre:String
}
struct Usuario:Decodable, Encodable{
    var correo:String
    var contrasenna: String
}
class ServicioWeb:ObservableObject
{
    var cancellableSet: Set<AnyCancellable> = []
    var IP = "http://192.168.1.124:8080/agregarArticulo"
    
    func registraUsuario(corr: String, contra: String, operacion:@escaping (String, String) -> Void)
    {
        guard let url=URL(string: "http://192.168.1.124:8080/agregarUsuario")
        else{
            return
        }
            
        print("Te digo")
        let usuario = Usuario(correo: corr, contrasenna: contra)
        var urlRequest=URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try? JSONEncoder().encode(usuario)
        URLSession.shared.dataTaskPublisher(for:urlRequest)
        //as URLRequest)
        
            .tryMap { (data: Data, response: URLResponse) -> Data  in
                print("Response :\(response)")
                
                let httpURLResponse=response as? HTTPURLResponse
                if let statusCode = httpURLResponse?.statusCode, statusCode != 200 {
                    throw NSError()
                }
                return data
            }
        
            .map{
                String(data: $0, encoding: .utf8)
            }  //Status//String//Int
            .receive(on: DispatchQueue.main)
            .sink {
                print("Sink \($0)")
            } receiveValue: { resultado in
                print("ReceiveValue \(resultado ?? "Nada")")
            }
            .store(in: &cancellableSet)
        
    }
    
    
    func subirPeliOserie(nom: String, operacion:@escaping (String) -> Void)
    {
        guard let url=URL(string: IP)
        else{
            return
        }
            
        print("Te digo")
        let pelicula = PeliculaOSerie(nombre: nom)
        var urlRequest=URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try? JSONEncoder().encode(pelicula)
        URLSession.shared.dataTaskPublisher(for:urlRequest)
        //as URLRequest)
        
            .tryMap { (data: Data, response: URLResponse) -> Data  in
                print("Response :\(response)")
                
                let httpURLResponse=response as? HTTPURLResponse
                if let statusCode = httpURLResponse?.statusCode, statusCode != 200 {
                    throw NSError()
                }
                return data
            }
        
            .map{
                String(data: $0, encoding: .utf8)
            }  //Status//String//Int
            .receive(on: DispatchQueue.main)
            .sink {
                print("Sink \($0)")
            } receiveValue: { resultado in
                print("ReceiveValue \(resultado ?? "Nada")")
            }
            .store(in: &cancellableSet)
    }
    func cargarServicioWebSeguro()
    {
        guard let url=URL(string: "http://172.30.206.114:8080/articulos")
        else{
            return
        }
        print("Te digo")
        
        URLSession.shared.dataTaskPublisher(for:url)
        
            .tryMap { (data: Data, response: URLResponse) -> Data  in
                print("Response :\(response)")
                
                let httpURLResponse=response as? HTTPURLResponse
                if let statusCode = httpURLResponse?.statusCode, statusCode != 200 {
                    throw NSError()
                }
                return data
            }
        
            .decode(type: [PeliculaOSerie].self, decoder: JSONDecoder())
            .map{
                print($0)
            }  //Status//String//Int
            .receive(on: DispatchQueue.main)
            .sink {
                print("Sink \($0)")
            } receiveValue: { status in
                print("ReceiveValue \(status)")
            }
            .store(in: &cancellableSet)
    }
    func cargarArticulos()
    {
        guard let url=URL(string: "https://reqbin.com/echo/get/json")
        else{
            return
        }
        print("Te digo")
        URLSession.shared.dataTaskPublisher(for:url)
        
            .tryMap { (data: Data, response: URLResponse) -> Data  in
                print("Response :\(response)")
                
                let httpURLResponse=response as? HTTPURLResponse
                if let statusCode = httpURLResponse?.statusCode, statusCode != 200 {
                    throw NSError()
                }
                return data
            }
        /*  .map{ data in
         
         return desencriptar(data)
         }*/
            .decode(type: Status.self, decoder: JSONDecoder())
            .map{
                $0.success.count
            }  //Status//String//Int
            .receive(on: DispatchQueue.main)
            .sink {
                print("Sink \($0)")
            } receiveValue: { status in
                print("ReceiveValue \(status)")
            }
            .store(in: &cancellableSet)
        
        
    }
}





//------------------------WL--------------------

struct Series:View{
    var series: Bool
    var body:some View{
        ScrollView{

            Text("Series").font(.custom("Courier", fixedSize: 30))
                .frame(width: 200, height: 50)
                .lineLimit(2)
                .lineSpacing(10)
            HStack{
                Image("startrek").resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(50)
                Text("Startrek").font(.custom("Courier", fixedSize: 30))
            }
            

        }
    }
    
}


struct Peliculas:View{
    var pelis: Bool
    var body:some View{
        ScrollView{

            Text("Películas").font(.custom("Courier", fixedSize: 30))
                .frame(width: 200, height: 50)
                .lineLimit(2)
                .lineSpacing(10)
            HStack{
                Image("peli4").resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(50)
                Text("Mulan").font(.custom("Courier", fixedSize: 30))
            }
            HStack{
                Image("peli2").resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(50)
                Text("Mulan").font(.custom("Courier", fixedSize: 30))
            }
            HStack{
                Image("peli5").resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(50)
                Text("Dune").font(.custom("Courier", fixedSize: 30))
            }
            HStack{
                Image("serie1").resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(50)
                Text("007").font(.custom("Courier", fixedSize: 30))
            }

        }
    }
    
}

struct PyS:View{
    var pelis: Bool
    var body:some View{
        ScrollView{

            Text("Películas y Series").font(.custom("Courier", fixedSize: 30))
                .frame(width: 400, height: 50)
                .lineLimit(2)
                .lineSpacing(10)
            HStack{
                Image("peli4").resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(50)
                Text("Mulan").font(.custom("Courier", fixedSize: 30))
            }
            HStack{
                Image("peli2").resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(50)
                Text("Mulan").font(.custom("Courier", fixedSize: 30))
            }
            HStack{
                Image("peli5").resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(50)
                Text("Dune").font(.custom("Courier", fixedSize: 30))
            }
            HStack{
                Image("serie1").resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(50)
                Text("007").font(.custom("Courier", fixedSize: 30))
            }
            HStack{
                Image("startrek").resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(50)
                Text("Startrek").font(.custom("Courier", fixedSize: 30))
            }

        }
    }
    
}



struct WactchedL:View{
    @State var nombre = ""
    var iniciar: Bool
    @State var pelis = false
    @State var series = false
    @StateObject var servicioWeb = ServicioWeb()
    var body:some View{
        VStack
        {
            Image("ojo").resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text("Watched").font(.custom("Courier", fixedSize: 40))
                .frame(width: 200, height: 50)
                .lineLimit(2)
                .lineSpacing(10)
            HStack{
                TextField("   Ingresar titulo de la serie o película",text: $nombre)
                Button {
                    servicioWeb.subirPeliOserie(nom: nombre){
                        nombre = $0
                    }
                } label: {
                    Text("Agregar".uppercased())
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.black)
                        .cornerRadius(15)
                }
            }
            
        }
        NavigationView {
                    VStack(spacing: 20) {

                        NavigationLink(destination: Peliculas(pelis:true)) {
                            Text("Peliculas".uppercased()).font(.largeTitle)
                                .foregroundColor(.yellow)
                        }

                        NavigationLink(destination: Series(series:true)) {
                            Text("Series".uppercased()).font(.largeTitle)
                                .foregroundColor(.yellow)
                        }
                    }
                }
            
        
    }
    
}


struct Top:View{
    @State var nombre = ""
    var iniciar: Bool
    @State var pelis = false
    @State var series = false
    @StateObject var servicioWeb = ServicioWeb()
    var body:some View{
        VStack
        {
            Image("ojo").resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text("TOP").font(.custom("Courier", fixedSize: 40))
                .frame(width: 200, height: 50)
                .lineLimit(2)
                .lineSpacing(10)
            
        }
        NavigationView {
                    VStack(spacing: 100) {

                        NavigationLink(destination: PyS(pelis:true)) {
                            Text("Peliculas y Series".uppercased()).font(.largeTitle)
                                .foregroundColor(.yellow)
                        }

                    }
                }
            
        
    }
    
}


struct Registro:View{
    @State var correo: String
    @State var contrasenna: String

    @StateObject var servicioWeb = ServicioWeb()
    var body:some View{
       
        ZStack
        {
            Color.yellow.ignoresSafeArea()
           
            VStack(spacing: 20)
            {

                Image("logo_updb").resizable()
                    .scaledToFit()
                    .frame(width: 125, height: 125)
                
                TextField("correo",text: $correo).font(.largeTitle)
                    .foregroundColor(.black)
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(8).frame(width: 300).multilineTextAlignment(.center)
                TextField("contraseña",text: $contrasenna).font(.largeTitle)
                    .foregroundColor(.black)
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(8).frame(width: 300).multilineTextAlignment(.center)
                Button {
                    servicioWeb.registraUsuario(corr: correo, contra: contrasenna){
                        correo = $0
                        contrasenna = $1
                    }
                } label: {
                    Text("Registrarse".uppercased()).font(.largeTitle)
                        .foregroundColor(.black)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(15)
                }
                
                NavigationLink(destination: WactchedL(iniciar: true)) {
                    Text("Watched".uppercased()).font(.largeTitle)
                        .foregroundColor(.black)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(15)
                }
                NavigationLink(destination: Top(iniciar: true)) {
                    Text("Top Films".uppercased()).font(.largeTitle)
                        .foregroundColor(.black)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(15)
                }

            }
            
            
        }
            
        
    }
    
}

//--------------------------------------------
struct ContentView: View{
    
    @State var corr = ""
    @State var contra = ""
    var body: some View {
        
        NavigationView{
            ZStack
            {
                Color.yellow.ignoresSafeArea()
               
                VStack
                {
                    Text("UPDb").font(.custom("Courier", fixedSize: 70))
                        .frame(width: 200, height: 100)
                        .lineLimit(2)
                        .lineSpacing(10)
                    Image("logo_updb").resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    
                    Text("DESCUBRE LAS MEJORES RECOMENDACIONES EN SERIES Y PELÍCULAS").font(.custom("arial", fixedSize: 25))
                        .frame(width: 350, height: 200).multilineTextAlignment(.center)
                    
                    NavigationLink(destination: Registro(correo:corr, contrasenna: contra)) {
                        Text("Iniciar".uppercased()).font(.largeTitle)
                            .foregroundColor(.yellow)
                            .padding(10)
                            .background(Color.black)
                            .cornerRadius(15)
                    }

                }
            }
            
        }

    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
