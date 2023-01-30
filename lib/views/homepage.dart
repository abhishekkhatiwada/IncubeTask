import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/api.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var api = Get.put(ApiController());
    return GetBuilder<ApiController>(builder: (_) {
      var data = api.data;
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: data.isNotEmpty
                ? DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      hint: Text(
                        'Select Item',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: api.months
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: api.selectedMonth,
                      onChanged: (value) {
                        api.sortBbyMonth(value);
                      },
                      buttonHeight: 40,
                      buttonWidth: 140,
                      itemHeight: 40,
                    ),
                  )
                : Container(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      api.selectedMonth ?? 'Baishak, 2079',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ],
                ),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: api.count,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return (api.selectedMonth == null)
                        ? Card(
                            child: Column(
                              children: [
                                const Text(
                                  'Gorkhapatra',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  data[index]['published_at'],
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  data[index]['n_questions'].toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                MaterialButton(
                                  height: 30,
                                  onPressed: () {},
                                  color: Colors.black,
                                  child: const Text(
                                    'Read',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : (data[index]['published_month'] == api.selectedMonth)
                            ? Card(
                                child: Column(
                                  children: [
                                    const Text(
                                      'Gorkhapatra',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      data[index]['published_at'],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      data[index]['n_questions'].toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    MaterialButton(
                                      height: 30,
                                      onPressed: () {},
                                      color: Colors.black,
                                      child: const Text(
                                        'Read',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container();
                  },
                ),
              ],
            ),
          ));
    });
  }
}
