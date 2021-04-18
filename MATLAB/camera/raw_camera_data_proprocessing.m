function y = raw_camera_data_proprocessing(point_coordinates) 
    y = [];

    coordinate_mean = mean(point_coordinates);

    count_less = 0;
    count_greater = 0;
    use_greater = true;

    for i = 1:size(point_coordinates)
        if point_coordinates(i) > coordinate_mean
            count_greater = count_greater + 1;
        else
            count_less = count_less + 1;
        end
    end

    if count_less > count_greater
       use_greater = false; 
    end

    for i = 1:size(point_coordinates)
        if use_greater
            if point_coordinates(i) >= coordinate_mean
                y = [y, point_coordinates(i)];
            else
                if size(y) > 0
                    y = [y, y(end)];
                else
                    y = [y, 0];
                end
            end
        else
            if point_coordinates(i) <= coordinate_mean
                y = [y, point_coordinates(i)];
            else
                if size(y) > 0
                    y = [y, y(end)];
                else
                    y = [y, 0];
                end
            end
        end
    end
end