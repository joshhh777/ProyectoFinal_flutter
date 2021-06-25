import http from 'http'

let notes = {
   "Adultos":[
      {
        id: 1,
        nombre: "Bicicleta Sunpeed Rule",
        imagen: "https://www.centerbike.com.pe/2941-home_default/bicicleta-sunpeed-rule.jpg",
        precio: "2390.00"
      },
      {
        id: 2,
        nombre: "Sava Deck 6.1",
        imagen: "https://www.centerbike.com.pe/2947-home_default/bicicleta-sava-deck-61-.jpg",
        precio: "4000.00"
      },
      {
        id: 3,
        nombre: "Sava Deck 6.0 Aro 29",
        imagen: "https://www.centerbike.com.pe/2937-home_default/bicicleta-sava-deck-60-aro275.jpg",
        precio: "4590.00"
      },
      {
        id: 4,
        nombre: "Sava Deck 6.0 Aro 27.5",
        imagen: "https://www.centerbike.com.pe/2935-home_default/bicicleta-sava-deck-60-aro-275.jpg",
        precio: "4190.00"
      },
      {
        id: 5,
        nombre: "Sava Deck 2.0 Aro 29",
        imagen: "https://www.centerbike.com.pe/2932-home_default/bicicleta-sava-deck-20-aro-29.jpg",
        precio: "3990.00"
      },
      {
        id: 6,
        nombre: "Sava Dek 2.0 Aro 27.5",
        imagen: "https://www.centerbike.com.pe/2931-home_default/bicicleta-sava-deck-20-aro-275.jpg",
        precio: "3790.00"
      },
      {
        id: 7,
        nombre: "Eleven Rocker II",
        imagen: "https://www.centerbike.com.pe/2384-home_default/eleven-rocker-ii.jpg",
        precio: "1490.00"
      },
      {
        id: 8,
        nombre: "Sunpeed Zero",
        imagen: "https://www.centerbike.com.pe/2209-home_default/sunpeed-zero.jpg",
        precio: "1390.00"
      },
      {
        id: 9,
        nombre: "Sunpeed One",
        imagen: "https://www.centerbike.com.pe/2161-home_default/sunpeed-one.jpg",
        precio: "1790.00"
      },
      {
        id: 10,
        nombre: "Firefox Raptor II",
        imagen: "https://www.centerbike.com.pe/2221-home_default/bicicleta-firefox-raptor-ii.jpg",
        precio: "990.00"
      },
      {
        id: 11,
        nombre: "Trex Trail Series",
        imagen: "https://www.centerbike.com.pe/2500-home_default/grupo-1.jpg",
        precio: "1100.00"
      },
      {
        id: 12,
        nombre: "VenusAro 27.5 Verde",
        imagen: "https://www.oxfordstore.pe/media/catalog/product/cache/1/image/1000x750/17f82f742ffe127f42dca9de82fb58b1/p/r/preview_venus-1_verde_2.jpg",
        precio: "1799.00"
      },
      {
        id: 13,
        nombre: "Merak Aro 27.5 Azul",
        imagen: "https://www.oxfordstore.pe/media/catalog/product/cache/1/image/1000x750/17f82f742ffe127f42dca9de82fb58b1/p/r/preview_merak-1_azul.jpg",
        precio: "1799.00"
      },
      {
        id: 14,
        nombre: "Orion Aro 27.5 Naranja",
        imagen: "https://www.oxfordstore.pe/media/catalog/product/cache/1/image/1000x750/17f82f742ffe127f42dca9de82fb58b1/b/a/ba2761_orion_4_27.5_naranja_2020_01.jpg",
        precio: "2500.00"
      },
      {
        id: 15,
        nombre: "HYDRA Aro 27.5 Negro",
        imagen: "https://www.oxfordstore.pe/media/catalog/product/cache/1/image/1000x750/17f82f742ffe127f42dca9de82fb58b1/b/a/ba2780-hydra-7-negro-2020-01.jpg",
        precio: "3600.00"
      }    
   ],
  "Chicos":[
      {
        id: 1,
        nombre: "Totem Aro 20",
        imagen: "https://www.centerbike.com.pe/2644-home_default/bicicleta-totem-aro-20-.jpg",
        precio: "690.00"
      },
      {
        id: 2,
        nombre: "Chip Munk ",
        imagen: "https://www.centerbike.com.pe/2513-home_default/bicicleta-chip-munk-nino.jpg",
        precio: "790.00"
      },
    ],
    "Accesorios":[
      {
        id: 1,
        nombre: "Guantes S209bk",
        imagen: "https://www.centerbike.com.pe/2873-home_default/guantes-s209bk-.jpg",
        precio: "75.00"
      },
      {
        id: 2,
        nombre: "Casco Cross Over",
        imagen: "https://www.centerbike.com.pe/2782-home_default/casco-cairbull-cross-over-cb-22.jpg",
        precio: "148.00"
      },
      {
        id: 3,
        nombre: "Casco Cairbull Joytrack",
        imagen: "https://www.centerbike.com.pe/2541-home_default/casco-cairbull-joytrack.jpg",
        precio: "118.00"
      },
      {
        id: 4,
        nombre: "Casco Cairbull Fungo",
        imagen: "https://www.centerbike.com.pe/2716-home_default/casco-cairbull-pungo.jpg",
        precio: "118.00"
      },
      {
        id: 5,
        nombre: "Casco Cairbull Allcross",
        imagen: "https://www.centerbike.com.pe/2755-home_default/casco-cairbull-allcross-.jpg",
        precio: "258.00"
      }
    ]
}
const app = http.createServer((request, response) => {
  response.writeHead(200, { 'Content-Type': 'application/json' })
  response.end(JSON.stringify(notes))
})

const PORT = 3001
app.listen(PORT)
console.log(`Server running on port ${PORT}`)