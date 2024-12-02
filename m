Return-Path: <linux-scsi+bounces-10407-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E823D9E014A
	for <lists+linux-scsi@lfdr.de>; Mon,  2 Dec 2024 13:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A913B282548
	for <lists+linux-scsi@lfdr.de>; Mon,  2 Dec 2024 12:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBE7201265;
	Mon,  2 Dec 2024 12:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="tTTV+9au"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DE31FECBC
	for <linux-scsi@vger.kernel.org>; Mon,  2 Dec 2024 12:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733140964; cv=none; b=XZXNij+/NDTw98aJozk+Q1ntA1H4yhKqcFAVTE56VQcc9DALfbPTRA0UvPoa3wtebRJAFOCpFDHPqCeoRf9nrFOaq6aaKmlC+Zoqn8azn9NyS+IerdneD7q1rSqwKQe0S3X7vzRT53p4GKVUgqtipdAcHpW9YmXnNd2RvIHkTZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733140964; c=relaxed/simple;
	bh=LzGMfdzUV+Y46qXBl6OSCXMbe5Hki1n9TnlpYa25zFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TiCQHEVmgbUcXEqjr0orj1TY2GeS8fCoxBpfKdwNZ8sEXoxBn427QLpPfzEU0WL6bztT7+eMpIXLTAGSrgyrV4stjTFfRzz368kksDV5coCw/vB0LdifVjsdCVsIcZ5DtnczIC8V11NkwfhPasWij5lBdjNpkna3wUVRMW+F1Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=tTTV+9au; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434ab938e37so25994895e9.0
        for <linux-scsi@vger.kernel.org>; Mon, 02 Dec 2024 04:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733140959; x=1733745759; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=isf4tmI1TFlpMNrHBrQw/VRoOgZ13JbCedLYTAnuHuc=;
        b=tTTV+9au9qIcZ5Q8CLfJAhN6vLQBy6U7CZ0YgQAFjIuLENgdRmwwNF8f7EhW5wC0k9
         9lSPx97C3Has535SwLqwsvxuvzXgbfC1YSWPAgbLhDp1fLchfgk7sZdisEeyTpKqoLab
         7yG6gFNq0aOSkcj4OmeMOVfEkw9peMDZ1ByHN86gPv/96iztrFRnGxFeDBrEYxWzHh6j
         AO0jo31NoK6Bie9hUvuuOPJOZsHfDZIrfETiiZ2un8+1i7beS3dzNiP+S6iTOYubRf/u
         BLYMlNjaAbviM3vNoCJFlH6u5VkMRZDQZmAmt0bOjswqw/XKV4l0ARur6MhI25qLpMkM
         ZQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733140959; x=1733745759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isf4tmI1TFlpMNrHBrQw/VRoOgZ13JbCedLYTAnuHuc=;
        b=q9yQztq+I0kfcyQ8fhgviOuqKlI7XqIMQW7no9Zu40tUldmhaZmDeTV3f5wVqg31Wy
         +0L8q4dhBD5ZgryCmYNDeprXu/ZwtLYOr387wpcFq6JaBOJJ/dfjMILoUfD+WoH65NSw
         hzXJ04qtEpRVK3hci+nKrUg3RthKo+HcYeiomq/Ce98GNnyEy+eHkSmAzijqRqgF/YYy
         3qNDhHilEkBRCesx+OERv2QxNkE02vVgvlW9W9noRCoV9SbfyaTCagr1grF5vO4Zfiom
         JXTDs6cdZqhNZBmYOUTydELjShGhLjq1ZwUce7E52kaxGc4zRI6GnK6fG05KwC9udQAp
         o3qw==
X-Forwarded-Encrypted: i=1; AJvYcCUTyHcRelc4Ihu9EvZhCWl8cvufheRk1mNM63EQFKEsm+DXpXBoWA3ApJWj4WPqqVsk+XZao7jojXPi@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7uQwcE5loVC2Fn6FPBcfoLgJ+9y4BAD8H14IZG2a0kYJ0fr09
	NJBlHx8q932MQYq8KMQ9BdjpU7cOSgWDX5WelMf1YCQc2VsNcd9KqrGeDOO+ouA=
X-Gm-Gg: ASbGncvbD8Ekv+qmzEtOgZiAdxKPXfWfJXVfO7kidE+alYm0V6+eTowygAGcR2VpeXO
	H5rg+UWgKa/AjSRsDYD1NL2n+R6xehx6DNpTJ18tyhZG9CuK0Ae9QMM6IpBcRRd9YIk/4n2USvv
	uQoHITkl8zBMoJnhqEG6LDUUH/Ex60P5soLGgd9ZsDbZjrVdevF207TlmD5G01fapClHMyO+HU9
	5edgcFJfm7ou/O3DzLFaMVziGdTF1toRnWXDD6R
X-Google-Smtp-Source: AGHT+IFyBiFCBHi0GjpQ9+378VjxeMr4mk7bXx5Q6Ff8EGSFk4eXjenWxQuJ2EnHaFTd+wgJcPjbew==
X-Received: by 2002:a05:600c:3151:b0:431:55af:a230 with SMTP id 5b1f17b1804b1-434a9e0a13bmr182587605e9.33.1733140958526;
        Mon, 02 Dec 2024 04:02:38 -0800 (PST)
Received: from [127.0.1.1] ([193.57.185.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bed7sm152396095e9.8.2024.12.02.04.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 04:02:37 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 02 Dec 2024 13:02:18 +0100
Subject: [PATCH RESEND v7 02/17] blk-crypto: show supported key types in
 sysfs
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-wrapped-keys-v7-2-67c3ca3f3282@linaro.org>
References: <20241202-wrapped-keys-v7-0-67c3ca3f3282@linaro.org>
In-Reply-To: <20241202-wrapped-keys-v7-0-67c3ca3f3282@linaro.org>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Asutosh Das <quic_asutoshd@quicinc.com>, 
 Ritesh Harjani <ritesh.list@gmail.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Gaurav Kashyap <quic_gaurkash@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-block@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, 
 linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Eric Biggers <ebiggers@google.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4358;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=ouSW/AlBhcEQvzE0ZK6zQ4sIBZ/J3LTs3gGhGDeZ9Qc=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnTaHRPDZZ8ak9Vx84mOBLXW+PqnaGDBHBzx25E
 5JBsjl2KNKJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ02h0QAKCRARpy6gFHHX
 clh8D/wONYkdQU4zXTyIM6UpM9KdOjBgXHgeuZVDZ7SAshMMizdm5gX9f7H2zVMdIuSt76K6d6u
 cMg1ZkazEPMCyGbGkMYTZgX1KLeOSX729FQkI/XGhdtucfMNRUPMkbXKB122qZE8LlhQvc6phKC
 p2UhVZeW64+Ra1c8GZeWM9Z3CDg4B58MlNsN/qGy/qiCtZHQ44502g4gF+xriuz50n1CdmIsmYD
 h+6gWYhQmIXJU8XtM5DNR7e2TTAGj38IeBH8695rLvG//xOrU6UqZ6PHfQff0LoYRkIQMfOFLK7
 woyqpgiSFr2jdfAREny4u1mhD/d3AvCn0Sy1STxH8iEJCMbzhE9gb7InwOge5q8D+tevPWGKhL5
 vSR/+ncRoSnWUDgzMY4NZimO0WaiQph4cS5SPzR7xr8sc1dD/GgPs9ZV3mSmnwUvOZZHsa5ws9x
 72dyysTG7nG+DL7gHfHA1qjiornBkIJDCDg1H3RNDgDrcO9B/6PtE9JI99WBm89ry4TiWDq45+s
 puBce4kKAEsPDwoB9/ySQ8b8PKGuly8pSzPw7GwFPtKD/9nU38/axyjeWHTJXZOep5oIF0jFLmY
 kXwzHyku949IdO50MvA9k+o7xIcBCLbPGABRHVrq9SAoUiNwCJ5aheX8QQPirCs9DeHh4bMKVC5
 Ehjgh9sDY2NqawA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Eric Biggers <ebiggers@google.com>

Add sysfs files that indicate which type(s) of keys are supported by the
inline encryption hardware associated with a particular request queue:

	/sys/block/$disk/queue/crypto/hw_wrapped_keys
	/sys/block/$disk/queue/crypto/standard_keys

Userspace can use the presence or absence of these files to decide what
encyption settings to use.

Don't use a single key_type file, as devices might support both key
types at the same time.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 Documentation/ABI/stable/sysfs-block | 18 ++++++++++++++++++
 block/blk-crypto-sysfs.c             | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 0cceb2badc836..998681e7043d5 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -229,6 +229,16 @@ Description:
 		encryption, refer to Documentation/block/inline-encryption.rst.
 
 
+What:		/sys/block/<disk>/queue/crypto/hw_wrapped_keys
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] The presence of this file indicates that the device
+		supports hardware-wrapped inline encryption keys, i.e. key blobs
+		that can only be unwrapped and used by dedicated hardware.  For
+		more information about hardware-wrapped inline encryption keys,
+		see Documentation/block/inline-encryption.rst.
+
+
 What:		/sys/block/<disk>/queue/crypto/max_dun_bits
 Date:		February 2022
 Contact:	linux-block@vger.kernel.org
@@ -267,6 +277,14 @@ Description:
 		use with inline encryption.
 
 
+What:		/sys/block/<disk>/queue/crypto/standard_keys
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] The presence of this file indicates that the device
+		supports standard inline encryption keys, i.e. keys that are
+		managed in raw, plaintext form in software.
+
+
 What:		/sys/block/<disk>/queue/dax
 Date:		June 2016
 Contact:	linux-block@vger.kernel.org
diff --git a/block/blk-crypto-sysfs.c b/block/blk-crypto-sysfs.c
index a304434489bac..acab50493f2cd 100644
--- a/block/blk-crypto-sysfs.c
+++ b/block/blk-crypto-sysfs.c
@@ -31,6 +31,13 @@ static struct blk_crypto_attr *attr_to_crypto_attr(struct attribute *attr)
 	return container_of(attr, struct blk_crypto_attr, attr);
 }
 
+static ssize_t hw_wrapped_keys_show(struct blk_crypto_profile *profile,
+				    struct blk_crypto_attr *attr, char *page)
+{
+	/* Always show supported, since the file doesn't exist otherwise. */
+	return sysfs_emit(page, "supported\n");
+}
+
 static ssize_t max_dun_bits_show(struct blk_crypto_profile *profile,
 				 struct blk_crypto_attr *attr, char *page)
 {
@@ -43,20 +50,48 @@ static ssize_t num_keyslots_show(struct blk_crypto_profile *profile,
 	return sysfs_emit(page, "%u\n", profile->num_slots);
 }
 
+static ssize_t standard_keys_show(struct blk_crypto_profile *profile,
+				  struct blk_crypto_attr *attr, char *page)
+{
+	/* Always show supported, since the file doesn't exist otherwise. */
+	return sysfs_emit(page, "supported\n");
+}
+
 #define BLK_CRYPTO_RO_ATTR(_name) \
 	static struct blk_crypto_attr _name##_attr = __ATTR_RO(_name)
 
+BLK_CRYPTO_RO_ATTR(hw_wrapped_keys);
 BLK_CRYPTO_RO_ATTR(max_dun_bits);
 BLK_CRYPTO_RO_ATTR(num_keyslots);
+BLK_CRYPTO_RO_ATTR(standard_keys);
+
+static umode_t blk_crypto_is_visible(struct kobject *kobj,
+				     struct attribute *attr, int n)
+{
+	struct blk_crypto_profile *profile = kobj_to_crypto_profile(kobj);
+	struct blk_crypto_attr *a = attr_to_crypto_attr(attr);
+
+	if (a == &hw_wrapped_keys_attr &&
+	    !(profile->key_types_supported & BLK_CRYPTO_KEY_TYPE_HW_WRAPPED))
+		return 0;
+	if (a == &standard_keys_attr &&
+	    !(profile->key_types_supported & BLK_CRYPTO_KEY_TYPE_STANDARD))
+		return 0;
+
+	return 0444;
+}
 
 static struct attribute *blk_crypto_attrs[] = {
+	&hw_wrapped_keys_attr.attr,
 	&max_dun_bits_attr.attr,
 	&num_keyslots_attr.attr,
+	&standard_keys_attr.attr,
 	NULL,
 };
 
 static const struct attribute_group blk_crypto_attr_group = {
 	.attrs = blk_crypto_attrs,
+	.is_visible = blk_crypto_is_visible,
 };
 
 /*

-- 
2.45.2


