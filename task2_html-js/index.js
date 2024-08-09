const cityWorkshop = [
    {
        city: "Город1",
        workshops: [ "Цех1-1", "Цех1-2", ], 
    },
    {
        city: "Город2",
        workshops: [ "Цех2-1", "Цех2-2", ], 
    },
];

const workshopEmployee = [
    {
        workshop: "Цех1-1",
        employees: [ "Сотрудник1-1-1", "Сотрудник1-1-2", ],
    },
    {
        workshop: "Цех1-2",
        employees: [ "Сотрудник1-2-1", "Сотрудник1-2-2", ],
    },
    {
        workshop: "Цех2-1",
        employees: [ "Сотрудник2-1-1", "Сотрудник2-1-2", ],
    },
    {
        workshop: "Цех2-2",
        employees: [ "Сотрудник2-2-1", "Сотрудник2-2-2", ],
    },
];

function createOptions(values, type, defaultName, selectedValue = "") {
    const selectNode = document.querySelector(`select#${type}`);
    selectNode.innerHTML = "";

    const defaultOptionNode = document.createElement("option");
    defaultOptionNode.value = "";
    defaultOptionNode.textContent = defaultName;
    selectNode.appendChild(defaultOptionNode);

    values.forEach(v => {
        const optionNode = document.createElement("option");
        optionNode.value = v;
        optionNode.textContent = v;

        selectNode.appendChild(optionNode);
    });

    selectNode.value = selectedValue;
}

function updateSelectOptions(c, e) {
    const city = document.querySelector("select#city").value;
    const workshop = document.querySelector("select#workshop").value;
    const employee = document.querySelector("select#employee").value;

    const cityValues =  new Set();
    const workshopValues =  new Set();
    const employeeValues =  new Set();

    for(let row of c) {
        if(isEqualOrEmpty(row[0], city) &&
            isEqualOrEmpty(row[1], workshop) &&
            isEqualOrEmpty(row[2], employee)) 
        {
            cityValues.add(row[0]);
            workshopValues.add(row[1]);
            employeeValues.add(row[2]);
        }
    }

    createOptions(cityValues, "city", "Выберите город", city);
    createOptions(workshopValues, "workshop", "Выберите цех", workshop);
    createOptions(employeeValues, "employee", "Выберите сотрудника", employee);
}

function isEqualOrEmpty(str, value) {
    return str === value || value === "";
}

function crossJoin(cities, workshops)
{
    const res = [];

    for(let i = 0; i < cities.length; i++) {
        const t = [cities[i].city];

        for(let j = 0; j < cities[i].workshops.length; j++) {
            t.push(cities[i].workshops[j]);

            const curw = workshops.filter(workshop => workshop.workshop === cities[i].workshops[j])[0];

            if(curw){
                for(let k = 0; k < curw.employees.length; k++) {
                    t.push(curw.employees[k]);
                    res.push([...t]);
                    t.pop();
                }
            }

            t.pop();
        }

        t.pop();
    }

    return res;
}

function init() {
    const cities = cityWorkshop.map(v => v.city);
    const workshop = workshopEmployee.map(v => v.workshop);
    const employees = workshopEmployee.map(v => v.employees).flat();

    createOptions(cities, "city", "Выберите город");
    createOptions(workshop, "workshop", "Выберите цех");
    createOptions(employees, "employee", "Выберите сотрудника");

    const crossJoinRes = crossJoin(cityWorkshop, workshopEmployee);

    document.querySelector("select#city").addEventListener("change", (e) => updateSelectOptions(crossJoinRes, e));
    document.querySelector("select#workshop").addEventListener("change", (e) => updateSelectOptions(crossJoinRes, e));
    document.querySelector("select#employee").addEventListener("change", (e) => updateSelectOptions(crossJoinRes, e));

    document.querySelector("form").addEventListener("submit", (e) => {
        e.preventDefault();

        const formData = new FormData(e.target);

        const jsonData = {};

        for(let v of formData.keys()) {
            jsonData[v] = formData.get(v);
        }

        document.cookie = "formJsonResult=" + JSON.stringify(jsonData) + ";SameSite=None;Secure=false";
    })
}

init();