Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5A5817245
	for <lists+linux-scsi@lfdr.de>; Wed,  8 May 2019 09:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfEHHEg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 8 May 2019 03:04:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41122 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726109AbfEHHEg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 8 May 2019 03:04:36 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4874S1j126322
        for <linux-scsi@vger.kernel.org>; Wed, 8 May 2019 03:04:35 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sbryukx1p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Wed, 08 May 2019 03:04:33 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-scsi@vger.kernel.org> from <alastair@au1.ibm.com>;
        Wed, 8 May 2019 08:02:47 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 May 2019 08:02:39 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4872cJb58392592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 May 2019 07:02:38 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 142EB4C044;
        Wed,  8 May 2019 07:02:38 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6538A4C04E;
        Wed,  8 May 2019 07:02:37 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  8 May 2019 07:02:37 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 38BE9A03B2;
        Wed,  8 May 2019 17:02:35 +1000 (AEST)
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     alastair@d-silva.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Karsten Keil <isdn@linux-pingi.de>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Andrew Morton <akpm@linux-foundation.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/7] lib/hexdump.c: Optionally suppress lines of repeated bytes
Date:   Wed,  8 May 2019 17:01:43 +1000
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190508070148.23130-1-alastair@au1.ibm.com>
References: <20190508070148.23130-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19050807-0012-0000-0000-000003196FA0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050807-0013-0000-0000-00002151EFD4
Message-Id: <20190508070148.23130-4-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-08_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905080046
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Alastair D'Silva <alastair@d-silva.org>

Some buffers may only be partially filled with useful data, while the rest
is padded (typically with 0x00 or 0xff).

This patch introduces a flag to allow the supression of lines of repeated
bytes, which are replaced with '** Skipped %u bytes of value 0x%x **'

An inline wrapper function is provided for backwards compatibility with
existing code, which maintains the original behaviour.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 include/linux/printk.h | 25 +++++++++---
 lib/hexdump.c          | 91 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 99 insertions(+), 17 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index d7c77ed1a4cb..938a67580d78 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -479,13 +479,18 @@ enum {
 	DUMP_PREFIX_ADDRESS,
 	DUMP_PREFIX_OFFSET
 };
+
 extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
 			      int groupsize, char *linebuf, size_t linebuflen,
 			      bool ascii);
+
+#define HEXDUMP_ASCII			(1 << 0)
+#define HEXDUMP_SUPPRESS_REPEATED	(1 << 1)
+
 #ifdef CONFIG_PRINTK
-extern void print_hex_dump(const char *level, const char *prefix_str,
+extern void print_hex_dump_ext(const char *level, const char *prefix_str,
 			   int prefix_type, int rowsize, int groupsize,
-			   const void *buf, size_t len, bool ascii);
+			   const void *buf, size_t len, u64 flags);
 #if defined(CONFIG_DYNAMIC_DEBUG)
 #define print_hex_dump_bytes(prefix_str, prefix_type, buf, len)	\
 	dynamic_hex_dump(prefix_str, prefix_type, 16, 1, buf, len, true)
@@ -494,18 +499,28 @@ extern void print_hex_dump_bytes(const char *prefix_str, int prefix_type,
 				 const void *buf, size_t len);
 #endif /* defined(CONFIG_DYNAMIC_DEBUG) */
 #else
-static inline void print_hex_dump(const char *level, const char *prefix_str,
+static inline void print_hex_dump_ext(const char *level, const char *prefix_str,
 				  int prefix_type, int rowsize, int groupsize,
-				  const void *buf, size_t len, bool ascii)
+				  const void *buf, size_t len, u64 flags)
 {
 }
 static inline void print_hex_dump_bytes(const char *prefix_str, int prefix_type,
 					const void *buf, size_t len)
 {
 }
-
 #endif
 
+static __always_inline void print_hex_dump(const char *level,
+					   const char *prefix_str,
+					   int prefix_type, int rowsize,
+					   int groupsize, const void *buf,
+					   size_t len, bool ascii)
+{
+	print_hex_dump_ext(level, prefix_str, prefix_type, rowsize, groupsize,
+			buf, len, ascii ? HEXDUMP_ASCII : 0);
+}
+
+
 #if defined(CONFIG_DYNAMIC_DEBUG)
 #define print_hex_dump_debug(prefix_str, prefix_type, rowsize,	\
 			     groupsize, buf, len, ascii)	\
diff --git a/lib/hexdump.c b/lib/hexdump.c
index 3943507bc0e9..d61a1e4f19fa 100644
--- a/lib/hexdump.c
+++ b/lib/hexdump.c
@@ -212,8 +212,44 @@ int hex_dump_to_buffer(const void *buf, size_t len, int rowsize, int groupsize,
 EXPORT_SYMBOL(hex_dump_to_buffer);
 
 #ifdef CONFIG_PRINTK
+
+/**
+ * Check if a buffer contains only a single byte value
+ * @buf: pointer to the buffer
+ * @len: the size of the buffer in bytes
+ * @val: outputs the value if if the bytes are identical
+ */
+static bool buf_is_all(const u8 *buf, size_t len, u8 *val_out)
+{
+	size_t i;
+	u8 val;
+
+	if (len <= 1)
+		return false;
+
+	val = buf[0];
+
+	for (i = 1; i < len; i++) {
+		if (buf[i] != val)
+			return false;
+	}
+
+	*val_out = val;
+	return true;
+}
+
+static void announce_skipped(const char *level, const char *prefix_str,
+				   u8 val, size_t count)
+{
+	if (count == 0)
+		return;
+
+	printk("%s%s ** Skipped %lu bytes of value 0x%x **\n",
+	       level, prefix_str, count, val);
+}
+
 /**
- * print_hex_dump - print a text hex dump to syslog for a binary blob of data
+ * print_hex_dump_ext: dump a binary blob of data to syslog in hexadecimal
  * @level: kernel log level (e.g. KERN_DEBUG)
  * @prefix_str: string to prefix each line with;
  *  caller supplies trailing spaces for alignment if desired
@@ -224,6 +260,10 @@ EXPORT_SYMBOL(hex_dump_to_buffer);
  * @buf: data blob to dump
  * @len: number of bytes in the @buf
  * @ascii: include ASCII after the hex output
+ * @flags: A bitwise OR of the following flags:
+ *	HEXDUMP_ASCII:			include ASCII after the hex output
+ *	HEXDUMP_SUPPRESS_REPEATED:	suppress repeated lines of identical
+ *					bytes
  *
  * Given a buffer of u8 data, print_hex_dump() prints a hex + ASCII dump
  * to the kernel log at the specified kernel log level, with an optional
@@ -234,22 +274,25 @@ EXPORT_SYMBOL(hex_dump_to_buffer);
  * (optionally) ASCII output.
  *
  * E.g.:
- *   print_hex_dump(KERN_DEBUG, "raw data: ", DUMP_PREFIX_ADDRESS,
- *		    16, 1, frame->data, frame->len, true);
+ *   print_hex_dump_ext(KERN_DEBUG, "raw data: ", DUMP_PREFIX_ADDRESS,
+ *		    16, 1, frame->data, frame->len, HEXDUMP_ASCII);
  *
  * Example output using %DUMP_PREFIX_OFFSET and 1-byte mode:
  * 0009ab42: 40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f  @ABCDEFGHIJKLMNO
  * Example output using %DUMP_PREFIX_ADDRESS and 4-byte mode:
  * ffffffff88089af0: 73727170 77767574 7b7a7978 7f7e7d7c  pqrstuvwxyz{|}~.
  */
-void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
-		    int rowsize, int groupsize,
-		    const void *buf, size_t len, bool ascii)
+void print_hex_dump_ext(const char *level, const char *prefix_str,
+			int prefix_type, int rowsize, int groupsize,
+			const void *buf, size_t len, u64 flags)
 {
 	const u8 *ptr = buf;
-	int i, linelen, remaining = len;
+	int i, remaining = len;
 	unsigned char *linebuf;
 	unsigned int linebuf_len;
+	u8 skipped_val = 0;
+	size_t skipped = 0;
+
 
 	if (rowsize % groupsize)
 		rowsize -= rowsize % groupsize;
@@ -266,11 +309,35 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
 	}
 
 	for (i = 0; i < len; i += rowsize) {
-		linelen = min(remaining, rowsize);
+		int linelen = min(remaining, rowsize);
 		remaining -= rowsize;
 
+		if (flags & HEXDUMP_SUPPRESS_REPEATED) {
+			u8 new_val;
+
+			if (buf_is_all(ptr + i, linelen, &new_val)) {
+				if (new_val == skipped_val) {
+					skipped += linelen;
+					continue;
+				} else {
+					announce_skipped(level, prefix_str,
+							 skipped_val, skipped);
+					skipped_val = new_val;
+					skipped = linelen;
+					continue;
+				}
+			}
+		}
+
+		if (skipped) {
+			announce_skipped(level, prefix_str, skipped_val,
+					 skipped);
+			skipped = 0;
+		}
+
 		hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
-				   linebuf, linebuf_len, ascii);
+				   linebuf, linebuf_len,
+				   flags & HEXDUMP_ASCII);
 
 		switch (prefix_type) {
 		case DUMP_PREFIX_ADDRESS:
@@ -288,7 +355,7 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
 
 	kfree(linebuf);
 }
-EXPORT_SYMBOL(print_hex_dump);
+EXPORT_SYMBOL(print_hex_dump_ext);
 
 #if !defined(CONFIG_DYNAMIC_DEBUG)
 /**
@@ -306,8 +373,8 @@ EXPORT_SYMBOL(print_hex_dump);
 void print_hex_dump_bytes(const char *prefix_str, int prefix_type,
 			  const void *buf, size_t len)
 {
-	print_hex_dump(KERN_DEBUG, prefix_str, prefix_type, 16, 1,
-		       buf, len, true);
+	print_hex_dump_ext(KERN_DEBUG, prefix_str, prefix_type, 16, 1,
+		       buf, len, HEXDUMP_ASCII);
 }
 EXPORT_SYMBOL(print_hex_dump_bytes);
 #endif /* !defined(CONFIG_DYNAMIC_DEBUG) */
-- 
2.21.0

