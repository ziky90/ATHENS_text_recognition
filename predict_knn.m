% function searching for the k nearest neighbours
function [output_class, pr] = predict_knn(features, labels, k, record)
    distances = zeros(size(labels,1), 1);
    for i = 1:size(labels,1)
        distances(i) = norm(features(i,:) - record);
    end
    [sortedValues,sortIndex] = sort(distances(:));
    label_positions = sortIndex(1:k);
    output_labels = char(zeros(k));
    for i = 1:k
        labels(label_positions(i));
        output_labels(i) = char(labels(label_positions(i)));
    end
    output_class = char(mode(double(output_labels)));
    counter = 0;
    for i=1:size(output_labels)
        comp = (output_class == output_labels(i));
        if comp(1) == 1
            counter = counter + 1;
        end
    end
    pr = counter;
end