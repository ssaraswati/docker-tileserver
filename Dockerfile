FROM dpokidov/gopnik
RUN mkdir /scripts
RUN mkdir /map_data
WORKDIR /

RUN apt-get update && \
    apt-get install -y git curl unzip node-carto mapnik-utils fontconfig && \
    rm -rf /var/lib/apt/lists/*


RUN wget https://github.com/adobe-fonts/source-sans-pro/archive/2.020R-ro/1.075R-it.tar.gz && \
    tar -xzvf 1.075R-it.tar.gz && \
    mkdir /usr/share/fonts/truetype/sourcepro-ttf/ && \
    cp source-sans-pro-2.020R-ro-1.075R-it/TTF/*.ttf /usr/share/fonts/truetype/sourcepro-ttf/ && \
    fc-cache && \
    rm 1.075R-it.tar.gz && \
    rm -rf source-sans-pro-2.020R-ro-1.075R-it

RUN git clone https://github.com/dooman87/openstreetmap-carto.git

COPY scripts/download.sh /scripts
RUN chmod 755 /scripts/download.sh
RUN ./scripts/download.sh

WORKDIR /openstreetmap-carto
RUN shapeindex --shape_files \
    data/simplified-water-polygons-complete-3857/simplified_water_polygons.shp \
    data/water-polygons-split-3857/water_polygons.shp \
    data/antarctica-icesheet-polygons-3857/icesheet_polygons.shp \
    data/antarctica-icesheet-outlines-3857/icesheet_outlines.shp \
    data/ne_110m_admin_0_boundary_lines_land/ne_110m_admin_0_boundary_lines_land.shp

COPY scripts/compile_style.sh /scripts
COPY scripts/run_render.sh /scripts

COPY entrypoint.sh /

COPY map_data/config.json /map_data/
RUN chmod 755 /scripts/*.sh && \
    chmod 755 /entrypoint.sh

WORKDIR /
ENTRYPOINT /entrypoint.sh