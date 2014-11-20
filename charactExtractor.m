function [outputVector] = charactExtractor(matrix)

    nonCenteredBWEM = thresholdDiscrimination(matrix) ; % turns the gray
                        % input matrix into a black&white matrix, with the 
                        % letter in white pixels
    horizCenteredBWEM = recenter(nonCenteredBWEM) ; % horizontally centers 
                                                    % the matrix and makes
                                                    % the letter 20px wide
    transposed = transpose(horizCenteredBWEM) ;
    transposedBWEM = recenter(transposed) ; % centers vertically and makes
                                            % the letter 20px tall
    
    BWEM = transpose(transposedBWEM) ;
    %imshow(BWEM) ;
    
    [nLines, nColumns] = size(BWEM) ;
    param = 1 ;
    caracMatrix = zeros(param,nLines+nColumns) ;
    
    % The following loops count the neumber of black pixels on each line 
    % and each column.
    
    for lineIndex = 1:nLines
        i = 1 ;
        for columnIndex = 1:nColumns
            if BWEM(lineIndex, columnIndex) == 0
                caracMatrix(i, lineIndex) = caracMatrix(i, lineIndex) +1 ;
            end
            if columnIndex > 1
                if BWEM (lineIndex, columnIndex) == 0 && BWEM(lineIndex, columnIndex-1) == 1
                    i = i+1 ;
                end
            end
        end
    end

    for column = 1:nColumns
        i = 1 ;
        for line = 1:nLines
            if BWEM(line, column) == 0
                caracMatrix(i, column+nLines) = caracMatrix(i, column+nLines) +1 ;
            end
            if line > 1
                if BWEM (line, column) == 0 && BWEM(line-1, column) == 1
                    i = i+1 ;
                end
            end
        end
    end
    totalWidth = param*(nLines+nColumns) ;
    
    % Returns the new-found information as a vector
    outputVector = reshape(caracMatrix, [1 totalWidth]) ;
end

