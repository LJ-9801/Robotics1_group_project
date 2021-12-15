function pos = get_duckie_position(camera)
    e=camera.snapshot;
    mkdir = new_yellow_mask(e);
    mkdir=imfill(mkdir,'holes');
    mkdir=bwareaopen(mkdir,20);
    labeledImage = bwlabel(mkdir);
    measurements = regionprops(labeledImage, 'BoundingBox', 'Area');
    subplot(1,2,1);
    imshow(e);
    subplot(1,2,2)
    imshow(e);
    hold on;
    for k = 1 : length(measurements)
            thisBB = measurements(k).BoundingBox;
            if thisBB(2)*thisBB(4) >= 3000
                rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
                'EdgeColor','b','LineWidth',2 );
            end
    end
    pos = [thisBB(1)+thisBB(3)/2;thisBB(2)+thisBB(4)/2];
end