% function searching for the k nearest neighbours
function [class] = predict_knn(features, labels, k, record)
    distances = zeros(size(labels,1), 1);
    for i = 1:size(labels,1)
        distances(i) = norm(features(i,:) - record);
    end
    [sortedValues,sortIndex] = sort(distances(:));
    label_positions = sortIndex(1:k);
    output_labels = char(zeros(k));
    for i = 1:k
        labels(label_positions(i))
        output_labels(i) = char(labels(label_positions(i)));
    end
    class = char(mode(double(output_labels)));
end