import java.util.Arrays;

class Iga {
  ArrayList<int[]> genes;
  ArrayList<ArrayList<int[]>> allGenerations;
  Table timeTable;
  Table generationsTable;

  int geneSize, node, generation;

  Iga(int _geneSize, int _node, int _num) {
    geneSize = _geneSize;
    node = _node;
    generation = 1;
    genes = makeRandomGenes(_num);
    allGenerations = new ArrayList<ArrayList<int[]>>();
    allGenerations.add(getGenes());

    timeTable = new Table();
    timeTable.addColumn("time");
    timeTable.addColumn("action");

    generationsTable = new Table();
    generationsTable.addColumn("generation");
    for (int i=0; i<geneSize; i++) {
      generationsTable.addColumn("genes"+(i+1));
    }
  }

  ArrayList<int[]> getGenes() {
    return new ArrayList<int[]>(genes);
  }

  int showGeneration() {
    return generation;
  }

  void calcNextGeneration(float[] values) {
    crossing(values);
    mutation(0.05);
    allGenerations.add(getGenes());
    generation++;
    addAction("forward to generation " + generation);
    println("This is generation of " + generation);
  }

  void crossing(float[] values) {
    println("crossing start");
    ArrayList<int[]> parentGenes = getGenes();
    ArrayList<int[]> combArray = combinations(values);
    genes = new ArrayList<int[]>();

    for (int i=0; i<combArray.size (); i++) {
      int[] crGene = new int[geneSize];
      int[] parts = combArray.get(i);

      int[] candidateGene0 = parentGenes.get(parts[0]);
      int[] candidateGene1 = parentGenes.get(parts[1]);

      for (int j=0; j<node; j++) {
        int startPoint = j*geneSize/node;
        int endPoint = (j+1)*geneSize/node;
        int partPoint = (int)random(geneSize/node);

        System.arraycopy(candidateGene0, startPoint, crGene, startPoint, partPoint);
        System.arraycopy(candidateGene1, startPoint  + partPoint, crGene, startPoint  + partPoint, endPoint+ - startPoint - partPoint);
      }

      genes.add(crGene);
    }
    println(genes.size() + " crossings generated");
  }

  void mutation(float mutationRate) {
    println("mutation start");
    int count = 0;
    for (int i=0; i<genes.size (); i++) {
      if (random(1)>mutationRate) continue;
      int mutationPoint = (int)random(geneSize);
      genes.get(i)[mutationPoint] = 1 - genes.get(i)[mutationPoint];
      count++;
    }
    println(count + " mutations generated");
  }

  ArrayList<int[]> combinations(float[] values) {
    ArrayList<int[]> combination = new ArrayList<int[]>();
    float[] n_values = normalizeValue(values);
    for (int i=0; i<n_values.length; i++) {
      int[] candidate = new int[2];
      candidate[0] = getIndex(random(1), n_values);
      candidate[1] = getIndex(random(1), n_values);
      combination.add(candidate);
    }
    return combination;
  }

  float[] normalizeValue(float[] values) {
    float[] normlizedValues = new float[values.length];
    float denominator = sum(values);
    for (int i=0; i<normlizedValues.length; i++) {
      normlizedValues[i] = map(values[i], 0, denominator, 0, 1);
    }
    return normlizedValues;
  }

  int getIndex(float p, float[] n_values) {
    float target = 0;
    for (int i=0; i<n_values.length; i++) {
      target += n_values[i];
      if (p < target) return i;
    }
    return -1;
  }

  int[] makeEmptyGene() {
    int[] empGene = new int[geneSize];
    for (int i=0; i<geneSize; i++) {
      empGene[i] = 0;
    }
    return empGene;
  }

  ArrayList<int[]> makeEmptyGenes(int n) {
    ArrayList<int[]> empGenes = new ArrayList<int[]>();
    for (int t=0; t < n; t++) {
      empGenes.add(makeEmptyGene());
    }
    return empGenes;
  }

  int[] makeRandomGene() {
    int[] empGene = new int[geneSize];
    for (int i=0; i<geneSize; i++) {
      empGene[i] = (int)random(2);
    }
    return empGene;
  }  

  ArrayList<int[]> makeRandomGenes(int n) {
    ArrayList<int[]> empGenes = new ArrayList<int[]>();
    for (int t=0; t < n; t++) {
      empGenes.add(makeRandomGene());
    }
    return empGenes;
  }

  void addAction(String line) {
    String time = "" + millis();
    TableRow newRow = timeTable.addRow();
    newRow.setString("time", time);
    newRow.setString("action", line);
  }

  void output() {
    int y = year();
    int mo = month();
    int d = day();
    int h = hour();
    int m = minute();
    int s = second();

    String fileName = y + "-" + mo + "-" + d + "-" + nf(h, 2) + "-" + nf(m, 2) + "-" + nf(s, 2);
    String actionFileName = "action-" + fileName;
    saveTable(timeTable, "data/" + actionFileName +".csv");

    for (int i=0; i<allGenerations.size (); i++) {
      TableRow newRow = generationsTable.addRow();
      ArrayList<int[]> tempGenes = new ArrayList<int[]>(allGenerations.get(i));
      String geneLine = ""+geneToString(tempGenes.get(0));
      newRow.setInt("generation", i);

      for (int j=0; j<tempGenes.size (); j++) {
        newRow.setString("genes"+(j+1), ""+geneToString(tempGenes.get(j)));
      }
    }
    String generationsFileName = "generations-" + fileName;
    saveTable(generationsTable, "data/" + generationsFileName +".csv");

    println("outputed");
  }
}

