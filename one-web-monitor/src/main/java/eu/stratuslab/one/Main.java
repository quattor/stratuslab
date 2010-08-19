package eu.stratuslab.one;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.w3c.dom.Document;
import org.xml.sax.SAXException;

public class Main {

	public static void main(String[] args) {

		if (args.length != 2) {
			System.err.println("file and xslt names are required");
			System.exit(1);
		}

		try {
			File input = new File(args[0]);
			FileInputStream xslt = new FileInputStream(args[1]);

			TransformerFactory factory = TransformerFactory.newInstance();

			Transformer transformer = null;
			try {
				Source xsltSource = new StreamSource(xslt);
				transformer = factory.newTransformer(xsltSource);
			} catch (TransformerConfigurationException e) {
				System.exit(1);
			}

			DocumentBuilderFactory dbfactory = DocumentBuilderFactory
					.newInstance();
			DocumentBuilder db = dbfactory.newDocumentBuilder();
			Document document = db.parse(input);

			Result result = new StreamResult(System.out);
			transformer.transform(new DOMSource(document), result);

		} catch (FileNotFoundException e) {
			e.printStackTrace();
			System.exit(1);
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
			System.exit(1);
		} catch (SAXException e) {
			e.printStackTrace();
			System.exit(1);
		} catch (IOException e) {
			e.printStackTrace();
			System.exit(1);
		} catch (TransformerException e) {
			e.printStackTrace();
			System.exit(1);
		}

	}

}
