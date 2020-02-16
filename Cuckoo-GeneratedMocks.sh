#!/bin/sh

# Define output file. Change "$PROJECT_DIR/Tests" to your test's root source folder, if it's not the default name.
PROJECT_DIR="."
PODS_ROOT="$PROJECT_DIR/Pods"
OUTPUT_FILE="$PROJECT_DIR/OpenJobsTests/GeneratedMocks.swift"
echo "Generated Mocks File = $OUTPUT_FILE"

# Define input directory. Change "$PROJECT_DIR" to your project's root source folder, if it's not the default name.
INPUT_DIR="$PROJECT_DIR/OpenJobs"
echo "Mocks Input Directory = $INPUT_DIR"

# Generate mock files, include as many input files as you'd like to create mocks for.
${PODS_ROOT}/Cuckoo/run generate --testable "OpenJobs" \
--output "${OUTPUT_FILE}" \
"${INPUT_DIR}/Networking/WebServiceProtocol.swift" \
"${INPUT_DIR}/APIWrappers/GetJobsHandlerProtocol.swift" \
"${INPUT_DIR}/CoreDataManager/CoreDataManagerDataSource.swift" \
"${INPUT_DIR}/ViewModel/JobsListInteractor.swift"

# ... and so forth
