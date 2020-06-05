(define (domain program1)

    (:requirements :strips :typing :negative-preconditions :equality)

    (:types
        operation - object
        assignment - object
        variable_name - object
        variable_value - object
    )

    (:predicates
        (variable_info ?variable - variable_name ?value - variable_value ?assignment_operation - assignment)
        (executed_assingment ?id - assignment)
        (executed_binary_operation ?a - assignment ?b - assignment ?id - operation ?c - assignment)
    )

    (:action assignment
        :parameters (
            ?var - variable_name
            ?value - variable_value
            ?operation_id - assignment
        )
        :precondition (and
            (not (executed_assingment ?operation_id))
            (variable_info ?var ?value ?operation_id)
        )
        :effect (and
            (executed_assingment ?operation_id)
        )
    )

    (:action binary_operation
        :parameters (
            ?varA - variable_name
            ?valueA - variable_value
            ?op_A - assignment
            ?varB - variable_name
            ?valueB - variable_value
            ?op_B - assignment
            ?varC - variable_name
            ?valueC - variable_value
            ?op_C - assignment
            ?operation_id - operation
        )
        :precondition (and
            (variable_info ?varA ?valueA ?op_A)
            (variable_info ?varB ?valueB ?op_B)
            (not (executed_binary_operation ?op_A ?op_B ?operation_id ?op_C))
            (executed_assingment ?op_A)
            (executed_assingment ?op_B)
        )
        :effect (and 
            (variable_info ?varC ?valueC ?op_C)
            (executed_binary_operation ?op_A ?op_B ?operation_id ?op_C)
        )
    )
)