#import "@preview/typslides:1.3.0": *

// Project configuration
#show: typslides.with(
  ratio: "16-9",
  theme: "bluey",
  font: "Fira Sans",
  font-size: 16pt,
  // link-style: "color",
  show-progress: true
)

#front-slide(
  title: "Numerical ecology presentation",
  subtitle: [Spatial and temporal variability of the macrobenthic community composition in the Florida Bay],
  authors: "Lucien Bastin",
  info: [#link("https://github.com/lbProg/Numerical-ecology-M2")],
)

#slide(title: [Study site])[
  #grid(
    columns: (75%, 25%),
    gutter: 5%,
    image("Images/map.svg"),
    [
      - Florida Bay
      - Low depth
      - High salinity except northeast
      - Macrobenthic communities
      - 18 stations
      - 1996, 1997 and 2000
    ]
  )
]

#focus-slide[
  #text(30pt)[What is the spatiotemporal structure of the macrobenthic communities in the Florida Bay between 1996 and 2000 ?]
]

#slide(title: [Problematic and objectives])[
  #framed[
    #text(20pt)[
      What is the spatiotemporal structure of the macrobenthic communities in the Florida Bay between 1996 and 2000 ?
    ]
  ]

  #v(10%)

  #text(20pt)[
    + How does the spatial structure of the Florida Bay macrobenthic communities evolve through time ?

    + Can we observe different communities in the northeast stations (with the lowest salinity) and the rest of the Bay ?

    + Has there been a shift in community composition between 1996 and 2000, and if yes, has it been the same everywhere ?
  ]
]

#slide(title: [Qualitative model])[
  #grid(
    columns: (75%, 25%),
    image("Images/RDA_1.svg"),
    grid(
      rows: (40%, 60%),
      image("Images/map.svg"),
      [
        - Space, time and interaction all significant

        - Three groups along northeast gradient

        - Different species along this gradient
      ]
    )
  )
]

#slide(title: [Quantitative model])[
  #grid(
    columns: (75%, 25%),
    image("Images/RDA_2.svg"),
    grid(
      rows: (40%, 60%),
      image("Images/map.svg"),
      [
        - Time gradient and spatial structure

        - Species more/less present in time
      ]
    )
  )
]

#slide(title: [Clustering])[
  #grid(
    columns: (75%, 25%),
    image("Images/clustering.svg"),
    [
      - Clusters may highlight spatial structures

      - Different clusters along northeast/southwest axis

      - Different clusters each year

      - Some stations always together
    ]
  )
]

#slide(title: [Ecological trajectories])[
  #grid(
    columns: (75%, 25%),
    image("Images/trajs.svg"),
    grid(
      rows: (40%, 60%),
      image("Images/map.svg"),
      [
        - Most stations : same pattern

        - Some stations backtrack

        - Northeast stations separated but same trajectories

        - Similar shift in community composition
      ]
    )
  )
]

#slide(title: [Trajectory metrics])[
  #grid(
    columns: (75%, 25%),
    gutter: 2%,
    image("Images/trajs_model.svg"),
    grid(
      rows: (40%, 60%),
      image("Images/map.svg"),
      [
        - Significant linear correlation

        - Trajectory length higher in northeast stations

        - More important ecological shift
      ]
    )
  )
]

#slide(title: [Conclusion])[
  #align(center)[
    #text(22pt)[
      Space, time and interaction affect community composition.

      #v(10%)

      Northeast/southwest gradient

      #v(10%)

      Relatively similar ecological shift
    ]
  ]
]