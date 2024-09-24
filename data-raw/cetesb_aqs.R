## code to prepare `DATASET` dataset goes here

cetesb_aqs <- read.table("cetesb_aqs.dat",
                          sep = ",", header = TRUE, dec = ".",
                          stringsAsFactors = F)

sao_paulo_city <- c(269, 91, 95, 73, 98, 83, 262,
                    266, 97, 270, 85, 96, 72, 284,
                    99, 63, 64)
rmsp <- c(118, 263, 92, 264, 279, 65, 120,
          100, 101, 272, 102, 86, 103)
litoral <- c(87, 119, 66, 258, 260)
interior <- c(290, 107, 106, 108, 89, 276, 275,
              248, 289, 259, 110, 109, 281, 111,
              117, 112, 113, 288, 88, 277, 278,
              273, 67, 256, 280, 116)

cetesb_aqs$loc[cetesb_aqs$code %in% sao_paulo_city] <- "São Paulo"
cetesb_aqs$loc[cetesb_aqs$code %in% rmsp] <- "MASP"
cetesb_aqs$loc[cetesb_aqs$code %in% litoral] <- "Coast"
cetesb_aqs$loc[cetesb_aqs$code %in% interior] <- "Interior"

missing_aqs <- data.frame(
  name = c("Lapa", "Perus", "Americana-Vila Sta Maria",
           "Paulínia-Sta Terezinha",  "Rio Claro-Jd.Guanabara",
           "São Sebastião" ),
  code = c(84, 293, 105, 291, 292, 294),
  lat = c(-23.50897, -23.41321, -22.72425,
          -22.78021, -22.43906, -23.8052),
  lon = c(-46.70122, -46.75605, -41.33955,
          -41.113904, -41.58144, -39.40007),
  loc = c("São Paulo", "São Paulo", "Interior", "Interior",
          "Interior", "Litoral")
)

cetesb_aqs <- rbind(cetesb_aqs, missing_aqs)
cetesb_aqs <- cetesb_aqs[order(cetesb_aqs$name), ]
row.names(cetesb_aqs) <- NULL

Encoding(cetesb_aqs$name) <- "UTF-8"
save(cetesb_aqs, file = "data/cetesb_aqs.rda")
usethis::use_data(cetesb_aqs, overwrite = TRUE)
