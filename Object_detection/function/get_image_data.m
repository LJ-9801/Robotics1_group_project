function points = get_image_data(image)

    [BW,maskedRGBImage] = createMask(image);
    xl = length(BW);
    yl = length(BW(:, 1));

    points = [];
    BW = flip(BW);

    for i = 1:xl
        for j = 1:yl
            if BW(j, i) == 1
                start_x = i - 20;
                end_x = i + 20;
                start_y = j - 20;
                end_y = j + 20;
                if end_x > xl
                    end_x = xl;
                end
                if end_y > yl
                    end_y = yl;
                end
                if start_x <= 0
                    start_x = 1;
                end
                if start_y <= 0
                    start_y = 1;
                end

                m = BW(start_y:end_y, start_x:end_x);

                num = sum(m(:) == 1);
                if num > 6
                    points = [points, [i; j]];
                end
            end
        end
    end
end