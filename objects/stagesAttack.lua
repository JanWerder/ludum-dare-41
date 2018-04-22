return { 
    {--stage 1
        {--wave 1
			{1,"pause",10},
            {3,"tomato",3}--number of creeps, type of creep, delay until next creeps are added (earliest spawn are the accumulated delays, if creepsToSpawn is empty)
        },
        {--wave 2
			{1,"pause",10},
            {3,"tomato",3},
			{1,"pause",2},
            {2,"carrot",1}
        },
        {--wave 3
			{1,"pause",10},
            {5,"tomato",3},
            {3,"carrot",1}
        }
    }
}