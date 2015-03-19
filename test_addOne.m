function tests = test_addOne()
% TEST_ADDONE: Test harness for the 2addOne" function.
tests = functiontests(localfunctions());
end %test_addOne

function testScalarDouble(T)
input = 1;
expected = 2;
actual = addOne(input);
verifyEqual(T, actual, expected, 'AbsTol', 1e-6)
% See also RELTOL option
end %testScalarDouble

function testComplex(T)
input = 3+5i;
expected = 4+5i;
actual = addOne(input);
verifyEqual(T, actual, expected, 'AbsTol', 1e-6);
end %testComplex

function testVector(T)
input = [0; 0; 0; 0];
expected = [1; 1; 1; 1];
actual = addOne(input);
verifyEqual(T, actual, expected, 'AbsTol', 1e-6);
end %testVector

function testMatrix(T)
input = eye(2);
expected = [2 1; 1 2];
actual = addOne(input);
verifyEqual(T, actual, expected, 'AbsTol', 1e-6);
end %testMatrix

function testChar(T)
input = 'Mike';
expected = 'Njlf';
actual = addOne(input);
verifyEqual(T, actual, expected, 'AbsTol', 1e-6);
end %testChar

% Verify the error responses (test that the function throws the right 
% errors)
function testNargin(T) %#ok<*DEFNU>
% Test with zero inputs
codeToEvaluate = @() addOne();
verifyError(T, codeToEvaluate, 'MATLAB:narginchk:notEnoughInputs')
% Test with too many inputs
codeToEvaluate = @() addOne(1, 1);
verifyError(T, codeToEvaluate, 'MATLAB:TooManyInputs')
end %testNargin

function testEmpty(T)
codeToEvaluate = @() addOne([]);
verifyError(T, codeToEvaluate, 'MATLAB:expectedNonempty')
end %testEmpty

function testNonDoubleNonChar(T)
codeToEvaluate = @() addOne(single(2));
verifyError(T, codeToEvaluate, 'MATLAB:invalidType')

% codeToEvaluate = @() addOne(int8(2));
% verifyError(T, codeToEvaluate, 'MATLAB:invalidType')
%table, logical, uint etc

end

function testNaNInf(T)
%Testing for NaN
input = NaN;
expected = NaN;
actual = addOne(input);
verifyEqual(T, actual, expected, 'AbsTol', 1e-6);
%Testing for Inf
input = [Inf, -Inf];
expected = [Inf, -Inf];
actual = addOne(input);
verifyEqual(T, actual, expected, 'AbsTol', 1e-6);
end %testNaNInf