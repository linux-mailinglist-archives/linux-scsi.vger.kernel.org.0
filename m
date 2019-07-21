Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E44FA6F39A
	for <lists+linux-scsi@lfdr.de>; Sun, 21 Jul 2019 16:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfGUOOB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 21 Jul 2019 10:14:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:36440 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbfGUOOB (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 21 Jul 2019 10:14:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jul 2019 07:14:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,291,1559545200"; 
   d="scan'208";a="159636198"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by orsmga007.jf.intel.com with ESMTP; 21 Jul 2019 07:13:57 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
Cc:     Alex Lemberg <Alex.Lemberg@wdc.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH RESEND] scsi: ufs: revamp string descriptor reading
Date:   Sun, 21 Jul 2019 17:02:12 +0300
Message-Id: <20190721140212.8980-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Define new a type: uc_string_id for easier string
handling and less casting. Reduce number or string
copies in price of a dynamic allocation.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Tested-by: Avri Altman <avri.altman@wdc.com>
---

Resend: It was reviewed by not merged.

 drivers/scsi/ufs/ufs-sysfs.c |  20 ++---
 drivers/scsi/ufs/ufs.h       |   2 +-
 drivers/scsi/ufs/ufshcd.c    | 164 +++++++++++++++++++++--------------
 drivers/scsi/ufs/ufshcd.h    |   9 +-
 4 files changed, 115 insertions(+), 80 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
index f478685122ff..13e357f01025 100644
--- a/drivers/scsi/ufs/ufs-sysfs.c
+++ b/drivers/scsi/ufs/ufs-sysfs.c
@@ -570,10 +570,11 @@ static ssize_t _name##_show(struct device *dev,				\
 	struct ufs_hba *hba = dev_get_drvdata(dev);			\
 	int ret;							\
 	int desc_len = QUERY_DESC_MAX_SIZE;				\
-	u8 *desc_buf;							\
+	char *desc_buf;							\
+									\
 	desc_buf = kzalloc(QUERY_DESC_MAX_SIZE, GFP_ATOMIC);		\
-	if (!desc_buf)							\
-		return -ENOMEM;						\
+	if (!desc_buf)                                                  \
+		return -ENOMEM;                                         \
 	ret = ufshcd_query_descriptor_retry(hba,			\
 		UPIU_QUERY_OPCODE_READ_DESC, QUERY_DESC_IDN_DEVICE,	\
 		0, 0, desc_buf, &desc_len);				\
@@ -582,14 +583,13 @@ static ssize_t _name##_show(struct device *dev,				\
 		goto out;						\
 	}								\
 	index = desc_buf[DEVICE_DESC_PARAM##_pname];			\
-	memset(desc_buf, 0, QUERY_DESC_MAX_SIZE);			\
-	if (ufshcd_read_string_desc(hba, index, desc_buf,		\
-		QUERY_DESC_MAX_SIZE, true)) {				\
-		ret = -EINVAL;						\
+	kfree(desc_buf);						\
+	desc_buf = NULL;						\
+	ret = ufshcd_read_string_desc(hba, index, &desc_buf,		\
+				      SD_ASCII_STD);			\
+	if (ret < 0)							\
 		goto out;						\
-	}								\
-	ret = snprintf(buf, PAGE_SIZE, "%s\n",				\
-		desc_buf + QUERY_DESC_HDR_SIZE);			\
+	ret = snprintf(buf, PAGE_SIZE, "%s\n", desc_buf);		\
 out:									\
 	kfree(desc_buf);						\
 	return ret;							\
diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
index 99a9c4d16f6b..b3e1b2a0f463 100644
--- a/drivers/scsi/ufs/ufs.h
+++ b/drivers/scsi/ufs/ufs.h
@@ -541,7 +541,7 @@ struct ufs_dev_info {
  */
 struct ufs_dev_desc {
 	u16 wmanufacturerid;
-	char model[MAX_MODEL_LEN + 1];
+	char *model;
 };
 
 /**
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index a3b6cd1a623d..e2740353332a 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -299,16 +299,6 @@ static void ufshcd_scsi_block_requests(struct ufs_hba *hba)
 		scsi_block_requests(hba->host);
 }
 
-/* replace non-printable or non-ASCII characters with spaces */
-static inline void ufshcd_remove_non_printable(char *val)
-{
-	if (!val)
-		return;
-
-	if (*val < 0x20 || *val > 0x7e)
-		*val = ' ';
-}
-
 static void ufshcd_add_cmd_upiu_trace(struct ufs_hba *hba, unsigned int tag,
 		const char *str)
 {
@@ -3130,7 +3120,7 @@ int ufshcd_read_desc_param(struct ufs_hba *hba,
 			   enum desc_idn desc_id,
 			   int desc_index,
 			   u8 param_offset,
-			   u8 *param_read_buf,
+			   void *param_read_buf,
 			   u8 param_size)
 {
 	int ret;
@@ -3198,7 +3188,7 @@ int ufshcd_read_desc_param(struct ufs_hba *hba,
 static inline int ufshcd_read_desc(struct ufs_hba *hba,
 				   enum desc_idn desc_id,
 				   int desc_index,
-				   u8 *buf,
+				   void *buf,
 				   u32 size)
 {
 	return ufshcd_read_desc_param(hba, desc_id, desc_index, 0, buf, size);
@@ -3216,49 +3206,78 @@ static int ufshcd_read_device_desc(struct ufs_hba *hba, u8 *buf, u32 size)
 	return ufshcd_read_desc(hba, QUERY_DESC_IDN_DEVICE, 0, buf, size);
 }
 
+/**
+ * struct uc_string_id - unicode string
+ *
+ * @len: size of this descriptor inclusive
+ * @type: descriptor type
+ * @uc: unicode string character
+ */
+struct uc_string_id {
+	u8 len;
+	u8 type;
+	wchar_t uc[0];
+} __packed;
+
+/* replace non-printable or non-ASCII characters with spaces */
+static inline char ufshcd_remove_non_printable(char ch)
+{
+	return (ch >= 0x20 && ch <= 0x7e) ? ch : ' ';
+}
+
 /**
  * ufshcd_read_string_desc - read string descriptor
  * @hba: pointer to adapter instance
  * @desc_index: descriptor index
- * @buf: pointer to buffer where descriptor would be read
- * @size: size of buf
+ * @buf: pointer to buffer where descriptor would be read,
+ *       the caller should free the memory.
  * @ascii: if true convert from unicode to ascii characters
+ *         null terminated string.
  *
- * Return 0 in case of success, non-zero otherwise
+ * Return:
+ * *      string size on success.
+ * *      -ENOMEM: on allocation failure
+ * *      -EINVAL: on a wrong parameter
  */
-int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
-			    u8 *buf, u32 size, bool ascii)
+int ufshcd_read_string_desc(struct ufs_hba *hba, u8 desc_index,
+			    char **buf, bool ascii)
 {
-	int err = 0;
+	struct uc_string_id *uc_str;
+	char *str;
+	int ret;
 
-	err = ufshcd_read_desc(hba,
-				QUERY_DESC_IDN_STRING, desc_index, buf, size);
+	if (!buf)
+		return -EINVAL;
 
-	if (err) {
-		dev_err(hba->dev, "%s: reading String Desc failed after %d retries. err = %d\n",
-			__func__, QUERY_REQ_RETRIES, err);
+	uc_str = kzalloc(QUERY_DESC_MAX_SIZE, GFP_KERNEL);
+	if (!uc_str)
+		return -ENOMEM;
+
+	ret = ufshcd_read_desc(hba, QUERY_DESC_IDN_STRING,
+			       desc_index, uc_str,
+			       QUERY_DESC_MAX_SIZE);
+	if (ret < 0) {
+		dev_err(hba->dev, "Reading String Desc failed after %d retries. err = %d\n",
+			QUERY_REQ_RETRIES, ret);
+		str = NULL;
+		goto out;
+	}
+
+	if (uc_str->len <= QUERY_DESC_HDR_SIZE) {
+		dev_dbg(hba->dev, "String Desc is of zero length\n");
+		str = NULL;
+		ret = 0;
 		goto out;
 	}
 
 	if (ascii) {
-		int desc_len;
-		int ascii_len;
+		ssize_t ascii_len;
 		int i;
-		char *buff_ascii;
-
-		desc_len = buf[0];
 		/* remove header and divide by 2 to move from UTF16 to UTF8 */
-		ascii_len = (desc_len - QUERY_DESC_HDR_SIZE) / 2 + 1;
-		if (size < ascii_len + QUERY_DESC_HDR_SIZE) {
-			dev_err(hba->dev, "%s: buffer allocated size is too small\n",
-					__func__);
-			err = -ENOMEM;
-			goto out;
-		}
-
-		buff_ascii = kmalloc(ascii_len, GFP_KERNEL);
-		if (!buff_ascii) {
-			err = -ENOMEM;
+		ascii_len = (uc_str->len - QUERY_DESC_HDR_SIZE) / 2 + 1;
+		str = kzalloc(ascii_len, GFP_KERNEL);
+		if (!str) {
+			ret = -ENOMEM;
 			goto out;
 		}
 
@@ -3266,22 +3285,29 @@ int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
 		 * the descriptor contains string in UTF16 format
 		 * we need to convert to utf-8 so it can be displayed
 		 */
-		utf16s_to_utf8s((wchar_t *)&buf[QUERY_DESC_HDR_SIZE],
-				desc_len - QUERY_DESC_HDR_SIZE,
-				UTF16_BIG_ENDIAN, buff_ascii, ascii_len);
+		ret = utf16s_to_utf8s(uc_str->uc,
+				      uc_str->len - QUERY_DESC_HDR_SIZE,
+				      UTF16_BIG_ENDIAN, str, ascii_len);
 
 		/* replace non-printable or non-ASCII characters with spaces */
-		for (i = 0; i < ascii_len; i++)
-			ufshcd_remove_non_printable(&buff_ascii[i]);
+		for (i = 0; i < ret; i++)
+			str[i] = ufshcd_remove_non_printable(str[i]);
 
-		memset(buf + QUERY_DESC_HDR_SIZE, 0,
-				size - QUERY_DESC_HDR_SIZE);
-		memcpy(buf + QUERY_DESC_HDR_SIZE, buff_ascii, ascii_len);
-		buf[QUERY_DESC_LENGTH_OFFSET] = ascii_len + QUERY_DESC_HDR_SIZE;
-		kfree(buff_ascii);
+		str[ret++] = '\0';
+
+	} else {
+		str = kzalloc(uc_str->len, GFP_KERNEL);
+		if (!str) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		memcpy(str, uc_str, uc_str->len);
+		ret = uc_str->len;
 	}
 out:
-	return err;
+	*buf = str;
+	kfree(uc_str);
+	return ret;
 }
 
 /**
@@ -6452,6 +6478,9 @@ static int ufs_get_device_desc(struct ufs_hba *hba,
 	u8 model_index;
 	u8 *desc_buf;
 
+	if (!dev_desc)
+		return -EINVAL;
+
 	buff_len = max_t(size_t, hba->desc_size.dev_desc,
 			 QUERY_DESC_MAX_SIZE + 1);
 	desc_buf = kmalloc(buff_len, GFP_KERNEL);
@@ -6475,31 +6504,31 @@ static int ufs_get_device_desc(struct ufs_hba *hba,
 				     desc_buf[DEVICE_DESC_PARAM_MANF_ID + 1];
 
 	model_index = desc_buf[DEVICE_DESC_PARAM_PRDCT_NAME];
-
-	/* Zero-pad entire buffer for string termination. */
-	memset(desc_buf, 0, buff_len);
-
-	err = ufshcd_read_string_desc(hba, model_index, desc_buf,
-				      QUERY_DESC_MAX_SIZE, true/*ASCII*/);
-	if (err) {
+	err = ufshcd_read_string_desc(hba, model_index,
+				      &dev_desc->model, SD_ASCII_STD);
+	if (err < 0) {
 		dev_err(hba->dev, "%s: Failed reading Product Name. err = %d\n",
 			__func__, err);
 		goto out;
 	}
 
-	desc_buf[QUERY_DESC_MAX_SIZE] = '\0';
-	strlcpy(dev_desc->model, (desc_buf + QUERY_DESC_HDR_SIZE),
-		min_t(u8, desc_buf[QUERY_DESC_LENGTH_OFFSET],
-		      MAX_MODEL_LEN));
-
-	/* Null terminate the model string */
-	dev_desc->model[MAX_MODEL_LEN] = '\0';
+	/*
+	 * ufshcd_read_string_desc returns size of the string
+	 * reset the error value
+	 */
+	err = 0;
 
 out:
 	kfree(desc_buf);
 	return err;
 }
 
+static void ufs_put_device_desc(struct ufs_dev_desc *dev_desc)
+{
+	kfree(dev_desc->model);
+	dev_desc->model = NULL;
+}
+
 static void ufs_fixup_device_setup(struct ufs_hba *hba,
 				   struct ufs_dev_desc *dev_desc)
 {
@@ -6508,8 +6537,9 @@ static void ufs_fixup_device_setup(struct ufs_hba *hba,
 	for (f = ufs_fixups; f->quirk; f++) {
 		if ((f->card.wmanufacturerid == dev_desc->wmanufacturerid ||
 		     f->card.wmanufacturerid == UFS_ANY_VENDOR) &&
-		    (STR_PRFX_EQUAL(f->card.model, dev_desc->model) ||
-		     !strcmp(f->card.model, UFS_ANY_MODEL)))
+		     ((dev_desc->model &&
+		       STR_PRFX_EQUAL(f->card.model, dev_desc->model)) ||
+		      !strcmp(f->card.model, UFS_ANY_MODEL)))
 			hba->dev_quirks |= f->quirk;
 	}
 }
@@ -6860,6 +6890,8 @@ static int ufshcd_probe_hba(struct ufs_hba *hba)
 	}
 
 	ufs_fixup_device_setup(hba, &card);
+	ufs_put_device_desc(&card);
+
 	ufshcd_tune_unipro_params(hba);
 
 	/* UFS device is also active now */
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 994d73d03207..10935548d1fc 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -885,14 +885,17 @@ int ufshcd_read_desc_param(struct ufs_hba *hba,
 			   enum desc_idn desc_id,
 			   int desc_index,
 			   u8 param_offset,
-			   u8 *param_read_buf,
+			   void *param_read_buf,
 			   u8 param_size);
 int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
 		      enum attr_idn idn, u8 index, u8 selector, u32 *attr_val);
 int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
 	enum flag_idn idn, bool *flag_res);
-int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
-			    u8 *buf, u32 size, bool ascii);
+
+#define SD_ASCII_STD true
+#define SD_RAW false
+int ufshcd_read_string_desc(struct ufs_hba *hba, u8 desc_index,
+			    char **buf, bool ascii);
 
 int ufshcd_hold(struct ufs_hba *hba, bool async);
 void ufshcd_release(struct ufs_hba *hba);
-- 
2.20.1

