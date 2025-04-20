USE AirReservationDB;

-- Clear existing data (if needed)
DELETE FROM ticket;
DELETE FROM seat;
DELETE FROM flight;
DELETE FROM airplane;
DELETE FROM passenger;
DELETE FROM airport;
DELETE FROM location;
DELETE FROM airline;

-- Locations
INSERT INTO location (region, country, location_address) VALUES
('Cairo', 'Egypt', 'Oruba Road, Heliopolis'),
('New York', 'USA', 'Jamaica, NY 11430'),
('New York', 'USA', '9400 Ditmars Blvd, East Elmhurst, NY 11369'),
('Los Angeles', 'USA', '1 World Way, Los Angeles, CA 90045'),
('Chicago', 'USA', '10000 W O''Hare Ave, Chicago, IL 60666'),
('San Francisco', 'USA', 'San Francisco, CA 94128'),
('Miami', 'USA', '2100 NW 42nd Ave, Miami, FL 33142'),
('London', 'UK', 'Longford TW6'),
('Paris', 'France', '95700 Roissy-en-France'),
('Tokyo', 'Japan', 'Narita, Chiba 282-0004'),
('Dubai', 'UAE', 'Dubai, UAE'),
('Sydney', 'Australia', 'Mascot NSW 2020, Australia'),
('Singapore', 'Singapore', 'Airport Boulevard, Singapore 819643'),
('Toronto', 'Canada', '6301 Silver Dart Drive, Mississauga');

-- Airports
INSERT INTO airport (code, airport_name, location_id) VALUES
('CAI', 'Cairo International Airport', (SELECT id FROM location WHERE location_address = 'Oruba Road, Heliopolis')),
('JFK', 'John F. Kennedy International Airport', (SELECT id FROM location WHERE location_address = 'Jamaica, NY 11430')),
('LGA', 'LaGuardia Airport', (SELECT id FROM location WHERE  location_address = '9400 Ditmars Blvd, East Elmhurst, NY 11369')),
('LAX', 'Los Angeles International Airport', (SELECT id FROM location WHERE  location_address = '1 World Way, Los Angeles, CA 90045')),
('ORD', 'O''Hare International Airport', (SELECT id FROM location WHERE  location_address = '10000 W O''Hare Ave, Chicago, IL 60666')),
('SFO', 'San Francisco International Airport', (SELECT id FROM location WHERE  location_address = 'San Francisco, CA 94128')),
('MIA', 'Miami International Airport', (SELECT id FROM location WHERE  location_address = '2100 NW 42nd Ave, Miami, FL 33142')),
('LHR', 'Heathrow Airport', (SELECT id FROM location WHERE  location_address = 'Longford TW6')),
('CDG', 'Charles de Gaulle Airport', (SELECT id FROM location WHERE  location_address = '95700 Roissy-en-France')),
('NRT', 'Narita International Airport', (SELECT id FROM location WHERE  location_address = 'Narita, Chiba 282-0004')),
('DXB', 'Dubai International Airport', (SELECT id FROM location WHERE  location_address = 'Dubai, UAE')),
('SYD', 'Sydney Kingsford Smith Airport', (SELECT id FROM location WHERE  location_address = 'Mascot NSW 2020, Australia')),
('SIN', 'Singapore Changi Airport', (SELECT id FROM location WHERE  location_address = 'Airport Boulevard, Singapore 819643')),
('YYZ', 'Toronto Pearson International Airport', (SELECT id FROM location WHERE  location_address = '6301 Silver Dart Drive, Mississauga'));

-- Seats
INSERT INTO seat (airplane_registration, seat_number, isle_id, class, is_available) VALUES
('N123DA', 1, 'A', 'Business', 1),
('N123DA', 1, 'B', 'Business', 1),
('N123DA', 1, 'C', 'Business', 1),
('N123DA', 1, 'D', 'Business', 1),
('N123DA', 1, 'E', 'Business', 1),
('N123DA', 1, 'F', 'Business', 1),
('N123DA', 2, 'A', 'Business', 1),
('N123DA', 2, 'B', 'Business', 1),
('N123DA', 2, 'C', 'Business', 1),
('N123DA', 2, 'D', 'Business', 1),
('N123DA', 2, 'E', 'Business', 1),
('N123DA', 2, 'F', 'Business', 1),
('N123DA', 3, 'A', 'Economy', 1),
('N123DA', 3, 'B', 'Economy', 1),
('N123DA', 3, 'C', 'Economy', 1),
('N123DA', 3, 'D', 'Economy', 1),
('N123DA', 3, 'E', 'Economy', 1),
('N123DA', 3, 'F', 'Economy', 1),
('N123DA', 4, 'A', 'Economy', 1),
('N123DA', 4, 'B', 'Economy', 1),
('N123DA', 4, 'C', 'Economy', 1),
('N123DA', 4, 'D', 'Economy', 1),
('N123DA', 4, 'E', 'Economy', 1),
('N123DA', 4, 'F', 'Economy', 1),
('N123DA', 5, 'A', 'Economy', 1),
('N123DA', 5, 'B', 'Economy', 1),
('N123DA', 5, 'C', 'Economy', 1),
('N123DA', 5, 'D', 'Economy', 1),
('N123DA', 5, 'E', 'Economy', 1),
('N123DA', 5, 'F', 'Economy', 1),
('N123DA', 6, 'A', 'Economy', 1),
('N123DA', 6, 'B', 'Economy', 1),
('N123DA', 6, 'C', 'Economy', 1),
('N123DA', 6, 'D', 'Economy', 1),
('N123DA', 6, 'E', 'Economy', 1),
('N123DA', 6, 'F', 'Economy', 1),
('N123DA', 7, 'A', 'Economy', 1),
('N123DA', 7, 'B', 'Economy', 1),
('N123DA', 7, 'C', 'Economy', 1),
('N123DA', 7, 'D', 'Economy', 1),
('N123DA', 7, 'E', 'Economy', 1),
('N123DA', 7, 'F', 'Economy', 1),
('N123DA', 8, 'A', 'Economy', 1),
('N123DA', 8, 'B', 'Economy', 1),
('N123DA', 8, 'C', 'Economy', 1),
('N123DA', 8, 'D', 'Economy', 1),
('N123DA', 8, 'E', 'Economy', 1),
('N123DA', 8, 'F', 'Economy', 1),
('N123DA', 9, 'A', 'Economy', 1),
('N123DA', 9, 'B', 'Economy', 1),
('N123DA', 9, 'C', 'Economy', 1),
('N123DA', 9, 'D', 'Economy', 1),
('N123DA', 9, 'E', 'Economy', 1),
('N123DA', 9, 'F', 'Economy', 1),
('N123DA', 10, 'A', 'Economy', 1),
('N123DA', 10, 'B', 'Economy', 1),
('N123DA', 10, 'C', 'Economy', 1),
('N123DA', 10, 'D', 'Economy', 1),
('N123DA', 10, 'E', 'Economy', 1),
('N123DA', 10, 'F', 'Economy', 1),
('N123DA', 11, 'A', 'Economy', 1),
('N123DA', 11, 'B', 'Economy', 1),
('N123DA', 11, 'C', 'Economy', 1),
('N123DA', 11, 'D', 'Economy', 1),
('N123DA', 11, 'E', 'Economy', 1),
('N123DA', 11, 'F', 'Economy', 1),
('N123DA', 12, 'A', 'Economy', 1),
('N123DA', 12, 'B', 'Economy', 1),
('N123DA', 12, 'C', 'Economy', 1),
('N123DA', 12, 'D', 'Economy', 1),
('N123DA', 12, 'E', 'Economy', 1),
('N123DA', 12, 'F', 'Economy', 1),
('N123DA', 13, 'A', 'Economy', 1),
('N123DA', 13, 'B', 'Economy', 1),
('N123DA', 13, 'C', 'Economy', 1),
('N123DA', 13, 'D', 'Economy', 1),
('N123DA', 13, 'E', 'Economy', 1),
('N123DA', 13, 'F', 'Economy', 1),
('N123DA', 14, 'A', 'Economy', 1),
('N123DA', 14, 'B', 'Economy', 1),
('N123DA', 14, 'C', 'Economy', 1),
('N123DA', 14, 'D', 'Economy', 1),
('N123DA', 14, 'E', 'Economy', 1),
('N123DA', 14, 'F', 'Economy', 1),
('N123DA', 15, 'A', 'Economy', 1),
('N123DA', 15, 'B', 'Economy', 1),
('N123DA', 15, 'C', 'Economy', 1),
('N123DA', 15, 'D', 'Economy', 1),
('N123DA', 15, 'E', 'Economy', 1),
('N123DA', 15, 'F', 'Economy', 1),
('N123DA', 16, 'A', 'Economy', 1),
('N123DA', 16, 'B', 'Economy', 1),
('N123DA', 16, 'C', 'Economy', 1),
('N123DA', 16, 'D', 'Economy', 1),
('N123DA', 16, 'E', 'Economy', 1),
('N123DA', 16, 'F', 'Economy', 1),
('N123DA', 17, 'A', 'Economy', 1),
('N123DA', 17, 'B', 'Economy', 1),
('N123DA', 17, 'C', 'Economy', 1),
('N123DA', 17, 'D', 'Economy', 1),
('N123DA', 17, 'E', 'Economy', 1),
('N123DA', 17, 'F', 'Economy', 1),
('N123DA', 18, 'A', 'Economy', 1),
('N123DA', 18, 'B', 'Economy', 1),
('N123DA', 18, 'C', 'Economy', 1),
('N123DA', 18, 'D', 'Economy', 1),
('N123DA', 18, 'E', 'Economy', 1),
('N123DA', 18, 'F', 'Economy', 1),
('N123DA', 19, 'A', 'Economy', 1),
('N123DA', 19, 'B', 'Economy', 1),
('N123DA', 19, 'C', 'Economy', 1),
('N123DA', 19, 'D', 'Economy', 1),
('N123DA', 19, 'E', 'Economy', 1),
('N123DA', 19, 'F', 'Economy', 1);

-- Airlines
INSERT INTO airline (airline_name, logo_url) VALUES
('Delta Air Lines', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADgAAAAcCAMAAAADZYwMAAAAnFBMVEX////o6Ojn5+e8ws7j4+P6+vrX2uFabIyzuscAEl3y5Ob05+n48fP59fX27e7u3N/q1djw8fHEd3/O0trl5+vCyNLc3+Toqq2pAADLsLMAGFuWoLMvS3Vwf5pTZ4mPma2nsL8AF1+BjqbQAAixIDB/ABYWOmzXV1/SABSsABiiXWbmr7LRABsAB1snRnTrwsTYwsXkmJzWoqbDn6Opv1ZFAAABD0lEQVQ4je2TYVPDIAyGsZSuxbFVq+sQKIi20811nfv//82U6Qcp283e+W3vXckF8iSQSxG6aoTo7ZTNxoBzSmk+rubdBTHxTUDhzd8gufgagcj77wtinPQ2wRiDKR76BT8enUUgVbnkziZPopJgVSU0mCqFxehnK8BmcshNX15r5sAGog2A1uWfpO446ztlhEwG4OrtvV7/gFb3FbXxwMYo5XObj82M1/wIJhkkVsYdTIzrxxaeWrRCbL3mkHK3Wq47ThlayLYqYEtL2UCUla0Fr4WKFvqjUu+F5X7/eThwFuja/yiOosh9CEWeYs8dwidG8/zEEkQII8HJO//seZeDdvmAzDvajfy5rvq7vgB50xDQGponJQAAAABJRU5ErkJggg=='),
('Emirates', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAA4CAMAAAC49krEAAAAaVBMVEXXGSH////VAADXFh7SAADVAATWDxnYHyf87+/ZKTDkeXzgX2Pvtbfkd3rtqqvWCRXaMTfcRUr0zc7xv8HWAA3rnZ/lgIP219jso6XcSk7++Pj65+jib3L43t/okJLdUVXbOj/gZmnmiYuec/tfAAABmklEQVRIie2Tba+jIBCFnQMKCIiiYH3X/v8fudhtb+4mu/Z+3aQnMQR8mHHOjFn20UcfffRNBUvPTzitWG5/QGJpeavYG4p1wDxpwjsuC4tfeXwLwsRakngLOrvZ7N5X9i0Y0QWOWzkhY1d1OxukMa0Om83FdkF29yFxpVAT1+1FerbpPpxqaW3b2P0TLPS2ylMj2Tpe1MOaWQ2q0bC091d1s+bwo5fhtMdfgsrDqhn3UvLZXYAZplZrPetgcZk6hZyIyGBIN/4C5kD+NJehrsUxSpoYO0fkD7nKtEY7lnrGGKtH4FgPpE/MVXFO+1cv0Uo1lE3NNOodTXQaDfYN3a3asWXOza/M1Rh3HGTI91Rq4rLvY+XNTkb7OA5jDN0LtLEbiAfJ+/QaS8XBjeRk0yE1qTj2BCV3xUAIE/cP8IbDp0Mq79TO0OOCLxDYHuAZkS83Pg7rCW7UQUDQb/O7QN5PNTX31Lhe0OA973tDkBU3iylNvz7nyAmlCseUE6JQBTKX/muRC5FWiMzl+Jo39nT35fFj/bb/X/QL0mIYplnAD9gAAAAASUVORK5CYII='),
('Lufthansa', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADgAAAAKCAMAAADW6m2KAAAAZlBMVEX///8AAADJys4AACrl5efY2dzg4OIAABqSlZ4ACDKusLbv7/DExcnP0NP19fZydoKZnKSlp64AABO4ub8AADFHTmFYXm0AAB1SWGiKjZZkaXcjL0l4fIcAAAkzO1IRIT8AFzkAACQeZrCOAAAA+0lEQVQokZ2S226DMAyGf0JOzYEAbgoECu37v+RMy9RVUy82y0rsxJ8jxwYggxDB488i1L5Gdbj6lSLupvyUUuqDb567sd83l0FQwrh8AMMTl4eBU8uegyRlJl1mUZauA9xEoGgJvm09ouWjGCePXKwQL5CuIOPq7NZtSnXqu3Z2JtZbqdQtpc1X3VjA8Z1x7y/SHTTgKtBmlIW1saWmM+FE8zopuDSPj/iGuMKfoIFjMMCuO5imdfHzA3Salr7dtM2Q6v1z6r6qqD/XPSpCqMaSmL2s+U69w9ANOc9kyin/bgcLt7bR0JxKKm4Ha5C+YZ81cG1RNBL/HYAvW2kOxBslKxcAAAAASUVORK5CYII='),
('Singapore Airlines', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADgAAAAVCAMAAAAkat3EAAAAkFBMVEX////8szP+69HT2eT8qgD8ryWSoLz8/P38tDn8rBH+4Lb8ryng4+vr7vPn6/GksMf+6Mv91p//9Ob/9+38tkL+2qfBydl2iq62vtD+3rBheqQ0WZGtuM1/kbL9yX4/YJT9wGP9zYf8u1P9xXP90pVPa5seS4lYcp8ORIWImbgnUIsAKnn/+/ZtgqnJ0d7+5cEDXVjRAAABvklEQVQ4jZ2SW5OiMBCFG5MQArnIxRCIXAZExBH8//9uA+7O+DBbNdoPVJ/mfAl9CoBXard/yf5dXvAel2AWv8W1H4Slb4AdCyPSvs7dSJQdCHs5n4SEjMRd5L0K9uzURit8emjk+wviyPgaQPm+e0jgvo9AD/naLG46iRUkLGRRXxOWbOBZSqq0UrIRo+EcZJmDmaTlA9WzUfQCZyqoM6YsWlMtCOk3cCrL5aiVhopfASzkuhEmV83ROGWO/gjnYdycB8YKL8piwjYpxDJvYM5HIyy1WlVaISqtVJMxpoILbDcCZFFwIKQg7LYqt5dwO3LQwvUKITfiaF0+V+CUEqtjA3eYnDoHdj+GRx+n03/y+V1NohgXeAe329N0noE28Ok3SBmgV2qrZkF28sU1n+XDkuK67+v+gDH7JuVUCTq6dNTRLQyN63mFSiPRuKC/ngTfcYj3OElY/wXmZVnBAFZf4AmcFwlomZeHJyuCQ1AEBXgfX5ywLn0+uAgnpeywWDq4eNA1n2Q520c4RRd3py7OICY/xvO/SrcPJSRNXTwu49+Vc7btPrwXxX4f1es53m+KOPDuZV7gygu2v/wPiQ8iTHillTgAAAAASUVORK5CYII='),
('Qatar Airways', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADgAAAAPCAMAAACGJ/w5AAAApVBMVEX////7/Py0nKbp4eX5+fr18PLIzNDj5ee6n6ytkJ3n3uJEAABeADL09PWiqbBhADZtKUk/AABYACmffIvWyM5SAByXnaWvjJ3R1NeohpWeeInh1drSwcl3OleJWG59RV9LAApuI0iUaXxoBj50MVG1usCdjZeJUWm+p7KMX3NiDzmmsbZ0N01TACKRbXyBUGa/ub/Is704AACcl6GBcHx+V2d+ho8uoulxAAABt0lEQVQokZ2S25KbMAyGxdEYMAlgwIADDY2XUzeUHvL+j1bLZHd22pu2ukAejT7plxDAf5iswn/Kd13L0o43vA28I/J3nC8EAa8JaC6RcJtL3vWmt/fJg/ban679ABBsOmJ9vs2nwXBKmy9exoEe3eAyo+oISTuaMBKb7y3ChCsFJ5IArEySZF2H8YW8DRo56M6Id/UV3ycbJ6kWinEKYcoBEuTUl9fGnp4kfTXufgaYdgdzDnAEumDfLdi0AOb7vuDdJcskI9ZHcL7p6raddU/QWaY82jHW92BA8TVteRFH98lIBJ626IoK+BCGAc4aa3DYw3A744xeWhtQFZHbFksT7O2hNb/qJQwXrQorFXrWwgYHh5XfJMQ17KkEkqxbUTvnbNnuwxOEfe5ine7gLmBqXGh22CX+qNqGXMulDdPL+b4lZZLF/TB/+LfOsmEZi1nmHCy8Eu/tLMxIrjL2o+jfGx7WcFYKXbJUwi99pUrmVKjC80DyDnctiDb2M9t/v6i1VOrhK/EQiXqAv065E1QNraeajiicEL1ZwuQfl0hcXVMwRgj4Qr9lMMphCtC4UWsRxth7/i9uOSQZcFnSaAAAAABJRU5ErkJggg=='),
('American Airlines', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADgAAAAkCAMAAADrTAnMAAAAwFBMVEX///+or7b29/flHCO+GiDJkZL8/Pxyf4vBxsvo6uuOmKHW2t3P09aepq7U19q+w8jg4uROYXGIk5zw8fLbHCL34uHKAADNGyLM6Pm84fff8vzV7foAoeYAqOik2PR9xuwAlNK71ukAfr4Dh8JicX9QjrsAb6x9iZQATpEARI2FosC7xdantMnAz9e0wsmPpbC6cnS0mJiVCgDlUFDvGyPtAA3wcHLm3Nzxm5zZAADywcLYi4u6AAC2PT+mAADbuLhMKa0hAAABW0lEQVRIie2SaVPCMBCGdxdtmqQhaSOXgheBoHhyeCP//1+ZgswItszIV3k+pLO7fWbybguwZ882mq3W8U7iSbvTPt3JPOt02s2dzPNA6W2NWSsx+lFcXHa73TKROeAmsTGA5mSSGLimcBpZDcNev9/vFXtcCY5CedReOpkax520iUKmHQewg8Hg6rpQVJlXWI21xBRVooDFCNYjMhB5BjscDm+4tb/FlChVidYJKoVGgKMUNRPKQbYMH3F5e3e/Fn3RJgCiKLQJuA3PUHOwRBZo+a61XD9wopIVOQKfb8qqzQnR46gxLtFAewRlBDLCRHkrM4wy8T0zo8lk+lQiMnDgZEgY9hLipjKN2Wohz9NKpTJ9KfR4KsKHkLgQkyByHnorc3wUeH0rvKkBg8JoEFbF0sRVJozPVtNavRGo18pylvP+cZBTttgtzD5zZvB3dX6YMzebv8Ge/8gXIoEYgkTAvzEAAAAASUVORK5CYII='),
('Air France', 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIADgAOAMBEQACEQEDEQH/xAAcAAEAAgMBAQEAAAAAAAAAAAAAAwcEBQYCCAH/xAAxEAABBAEBBgMFCQAAAAAAAAABAAIDBBEGBRITITFBFWFxIiMyUdEHFBZSVYGUseH/xAAbAQEAAgMBAQAAAAAAAAAAAAAAAgUBAwQHBv/EAC4RAAICAAIHBgcBAAAAAAAAAAABAgMEEQUSITFRYdEGExQiQeFCUlORkqHBFf/aAAwDAQACEQMRAD8AvFAEAQBAEAQBAEAQBAQXLdajCZrliKvECAXyvDW59SsOSis2TrqnbLVri2+W0wfxLsL9a2d/KZ9VDvq/mX3On/Pxn0pfi+hn1Lde7AJ6c8U8LsgSRPDmnHXmFNNSWaOayudctWaafBkyyQCAIAeQyUBSH2j6n8d2n91qvzQquIYR0kf0LvTsP9VRiru8lqrcj0Ts/ovwlPe2Lzy/S4dTT6U2BPqLa8dOLebEPanlA+Bnf9+wWqmp2zyLDSmkI4HDux7/AEXFn0DTqw0qsVWtGI4YmhjGjsArtJRWSPLrLJWzc5vNsmWSAQBAcD9qOqfDqfhFGTFuy33rmnnHH9T/AFnyXFi79Rai3s+l7PaL8Rb4ixeSO7m/YqGGKSeVkMLC+R7g1jWjmSegVWk28kffTnGuLlJ5JF96I03HpzY7YXBptzYfYeO7vyjyH1PdXVFKqhl6nl+ltIyx2Ic/hWxLl7nQreVgQBAarbt+pWbFWsbUdQmna90ZYGl7gxuXYy09B5LDi2thOucYSzlFPk8/40V/Y05o2zPNNY1DtGWbiPEr3cyXN+LJ4fbIXM8DFvNtl/X2mxNUVCEIpLk+puNO0dFbCkjtVrolsOj4kc1gkuazf4e8BgAe0cZx8+y2VYWFbzS2nFjtNYrGx1LHlHgth0sep9jSMikjub0cz+HHI2J5a92M4DsYK36rKrMzq+0K1m3ZqwPL5axAlw07rSRnGemcduygpJtpehtnTOEIzktktxlKRqCAimrV588eCKTIAO+wHocjr5oDyKVUFxFaEFzS13uxzB6j0QH4KVQEEVYAQ/fB4Y+L5+vmgPHhezt4O+4Vd4YweC3PLp27ICeKGKEOEMbIw5xcQ1oGSep9VhJIy5OW9kiyYCAIAgCAIAgCA//Z'),
('Turkish Airlines', 'data:image/jpeg;base64,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');

-- Airplanes with multiple entries per airline
INSERT INTO airplane (registration, model, max_capacity, airline_name) VALUES
-- Delta Air Lines
('N123DA', 'Boeing 737-800', 160, 'Delta Air Lines'),
('N456DL', 'Boeing 767-300ER', 216, 'Delta Air Lines'),
('N789DN', 'Airbus A321', 192, 'Delta Air Lines'),

-- Emirates
('A6-EAA', 'Airbus A380', 517, 'Emirates'),
('A6-EBB', 'Boeing 777-300ER', 354, 'Emirates'),
('A6-ECC', 'Boeing 777-200LR', 302, 'Emirates'),

-- Lufthansa
('D-ABYA', 'Airbus A350-900', 293, 'Lufthansa'),
('D-ABYB', 'Airbus A340-600', 281, 'Lufthansa'),
('D-ABYC', 'Boeing 747-8', 364, 'Lufthansa'),

-- Singapore Airlines
('9V-SQA', 'Boeing 777-300ER', 264, 'Singapore Airlines'),
('9V-SQB', 'Airbus A380', 471, 'Singapore Airlines'),
('9V-SQC', 'Airbus A350-900ULR', 161, 'Singapore Airlines'),

-- Qatar Airways
('A7-ANA', 'Airbus A350-1000', 327, 'Qatar Airways'),
('A7-ANB', 'Boeing 787-8', 254, 'Qatar Airways'),
('A7-ANC', 'Boeing 777-300ER', 354, 'Qatar Airways'),

-- American Airlines
('N123AA', 'Boeing 787-9', 285, 'American Airlines'),
('N456AN', 'Airbus A321neo', 196, 'American Airlines'),
('N789AM', 'Boeing 737 MAX 8', 172, 'American Airlines'),

-- Air France
('F-AAAA', 'Airbus A320', 174, 'Air France'),
('F-BBBB', 'Boeing 777-200ER', 280, 'Air France'),
('F-CCCC', 'Airbus A350-900', 324, 'Air France'),

-- Turkish Airlines
('TC-AAA', 'Boeing 737 MAX 8', 189, 'Turkish Airlines'),
('TC-BBB', 'Airbus A321neo', 206, 'Turkish Airlines'),
('TC-CCC', 'Boeing 787-9 Dreamliner', 300, 'Turkish Airlines');

-- Inserting flight data
INSERT INTO flight (airline_name, flight_number, from_airport_code, to_airport_code, airplane_registration, departure_time, duration, status, base_price) VALUES
-- Delta flights (US domestic)
('Delta Air Lines', 'DL123', 'JFK', 'LAX', 'N123DA', '2025-06-15 08:00:00', 300, 'On Time', 299),
('Delta Air Lines', 'DL456', 'LAX', 'JFK', 'N456DL', '2025-06-15 12:30:00', 310, 'On Time', 299),
('Delta Air Lines', 'DL789', 'JFK', 'ORD', 'N789DN', '2025-06-16 07:45:00', 135, 'On Time', 149),

-- Emirates flights (long-haul)
('Emirates', 'EK123', 'DXB', 'JFK', 'A6-EAA', '2025-06-15 22:30:00', 780, 'On Time', 1299),
('Emirates', 'EK456', 'JFK', 'DXB', 'A6-EBB', '2025-06-16 01:15:00', 795, 'On Time', 1299),
('Emirates', 'EK789', 'DXB', 'LHR', 'A6-ECC', '2025-06-17 08:00:00', 420, 'On Time', 599),

-- Lufthansa flights (mixed)
('Lufthansa', 'LH123', 'LHR', 'CDG', 'D-ABYA', '2025-06-15 09:30:00', 75, 'On Time', 199),
('Lufthansa', 'LH456', 'CDG', 'JFK', 'D-ABYB', '2025-06-16 14:00:00', 480, 'On Time', 899),
('Lufthansa', 'LH789', 'LHR', 'ORD', 'D-ABYC', '2025-06-17 10:15:00', 510, 'On Time', 899),

-- Singapore Airlines flights (long-haul)
('Singapore Airlines', 'SQ123', 'SIN', 'SYD', '9V-SQA', '2025-06-15 23:55:00', 480, 'On Time', 499),
('Singapore Airlines', 'SQ456', 'SYD', 'LAX', '9V-SQB', '2025-06-16 11:30:00', 840, 'On Time', 1199),
('Singapore Airlines', 'SQ789', 'SIN', 'NRT', '9V-SQC', '2025-06-18 08:45:00', 360, 'On Time', 399),

-- Qatar Airways flights
('Qatar Airways', 'QR123', 'DXB', 'CDG', 'A7-ANA', '2025-06-16 03:30:00', 390, 'Delayed', 699),
('Qatar Airways', 'QR456', 'CDG', 'JFK', 'A7-ANB', '2025-06-17 16:45:00', 495, 'On Time', 1099),
('Qatar Airways', 'QR789', 'DXB', 'ORD', 'A7-ANC', '2025-06-18 09:00:00', 840, 'On Time', 1299),

-- American Airlines flights (US domestic)
('American Airlines', 'AA123', 'JFK', 'MIA', 'N123AA', '2025-06-15 06:30:00', 180, 'On Time', 199),
('American Airlines', 'AA456', 'ORD', 'LAX', 'N456AN', '2025-06-16 13:15:00', 240, 'On Time', 249),
('American Airlines', 'AA789', 'LAX', 'YYZ', 'N789AM', '2025-06-17 17:00:00', 300, 'Cancelled', 349),

-- Air France flights
('Air France', 'AF123', 'CDG', 'LHR', 'F-AAAA', '2025-06-16 08:45:00', 70, 'On Time', 149),
('Air France', 'AF456', 'JFK', 'CDG', 'F-BBBB', '2025-06-17 19:30:00', 420, 'On Time', 899),
('Air France', 'AF789', 'CDG', 'CAI', 'F-CCCC', '2025-06-18 10:00:00', 240, 'On Time', 399),

-- Turkish Airlines flights
('Turkish Airlines', 'TK123', 'LHR', 'JFK', 'TC-AAA', '2025-06-15 15:45:00', 600, 'On Time', 999),
('Turkish Airlines', 'TK456', 'ORD', 'LHR', 'TC-BBB', '2025-06-16 18:30:00', 615, 'On Time', 999),
('Turkish Airlines', 'TK789', 'JFK', 'LHR', 'TC-CCC', '2025-06-17 22:00:00', 590, 'Delayed', 999);
