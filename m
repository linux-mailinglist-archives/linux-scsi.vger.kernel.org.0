Return-Path: <linux-scsi+bounces-2993-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E39872C28
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Mar 2024 02:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680CC1C24F26
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Mar 2024 01:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D82D1B968;
	Wed,  6 Mar 2024 01:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vmZ7zN0y"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81F41B7FB
	for <linux-scsi@vger.kernel.org>; Wed,  6 Mar 2024 01:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709688165; cv=none; b=K5bHjack59VneQRIY0QAuFMdLUx4M4YTZ46+APsmrl+3tWmfJvTtkjziywpyNgKcVT1kuuVXI+Ks9lRytrUZWmXbh3+mZucW1lnhZP+tRg8Plr6x8/DPC8RSjsJKjiCREQE3dPjYyanGoJcUU6QmV46vrxkaK4TFu8eWVg/WWVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709688165; c=relaxed/simple;
	bh=G9sVD8mPANACI8XvBa42u5K2t+gtYc3kf7MUNETx/FI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ohOPFTJ6ooN5znmu7vnalcfIL3TtlsFReyyktBUGW7V6bAmGKdi7zmOzof7aYNwUsuZwpxKeRrwWZa595JC9PKLA1C2v5FObCTtzPHlLhM4q5M42nfN5Ny9qKRXHSKgpfdKwv1CNJcf6DQ4FLLdYhusRYKdT/Vvvob3ehvjVxHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vmZ7zN0y; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609db871b90so585797b3.1
        for <linux-scsi@vger.kernel.org>; Tue, 05 Mar 2024 17:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709688163; x=1710292963; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RQNseeqHGtqWgtmESvK7C+bOjnnAotGHLghFADtiiV8=;
        b=vmZ7zN0y7oAQ3o1IYvC/6G7lp8KHoWrQ8P/DlIeuymJNgS2JfZzSlC6Hlbk9cV8Nt6
         qiFHpiWvX7iq4uR/jcnOw8b5wo/ogwn7Tv20+DGsa65zU7iOxtnWxYfqqqSjNEa5kpQu
         xWsASHAXgole+8k0MdUHd27VmYNOoHyWQEttpc5ahLz+DO6bZ7aOeucvpzsx+XNQ3+1c
         DuSW7FR1BfE4zZwkNvWxNrkDAm24DzXc4Yz/+sDNjbPcflQW0wRuaoxR0NRisFdEVqXe
         bdqNfyuKXFfeM3MoemIg2y+PsIUAkP0xqz2LZOvjB9p1hATN4ADILTGvlP5zjIOSwaii
         OJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709688163; x=1710292963;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RQNseeqHGtqWgtmESvK7C+bOjnnAotGHLghFADtiiV8=;
        b=bBEpM15v/mQZnggp6lUFaD1HxSjLjWu5VeRrb1Gch0ScTLmVRFcwT6dZGiQEb0tE2B
         uNW1nJI1DMc/hN+RQeWWoGNWwsnpu6/H79MSU1uB7IzJgfQxtsL5yooSCvvva8Mm61rx
         vxaf9IWJOCXzHgDHGrdd0/7kc7GJyqTBPl3CFPEgx/PPOhGUmAoMEzVuy+zU5yEiZCsi
         w+VkbLhs6sHN0vC43nzE6MBCABRq4/NzedXa0xrVqwt7Uo462mHV5O/BGO97J5GxbaGW
         FOGcHyiGTUD88MSCX5N8MZPtGfnN0lVyUkKE/OgvMzszLabPQNgNLkmqR9i9n5ywpqwQ
         wCqw==
X-Forwarded-Encrypted: i=1; AJvYcCWC6vzi94jyMWjBSNKY1fOyqH5rCzRcuAWU3jiYoP/WT7S0/2Mh+N5oxlkdnOivpl+LBTw9b7UYh8m1f+p4l0gX4ERT1b/SkFwlkQ==
X-Gm-Message-State: AOJu0Yx5dDOVOdPqaHfqFaeIe8z9R3+R06aCYg/btBTl16eqFiyaC+BR
	+uKoe3+rFPp88qUpT2TB6Blm+m6SOEloGWSnlSv9jJDhZmaRLd3uox9WU6KuLrffA/lBOWNOng5
	mVzdnzzO67Q==
X-Google-Smtp-Source: AGHT+IHuf14WoeiNOQZD94FHubDwGQvZY9g2Mcsd57WWqKCAzXJp6IFbF7d+D3UEyzS77tOP8GcP5CmNZmrWww==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:69ff:df2c:aa81:7b74])
 (user=ipylypiv job=sendgmr) by 2002:a25:260f:0:b0:dcc:f01f:65e1 with SMTP id
 m15-20020a25260f000000b00dccf01f65e1mr3520928ybm.8.1709688162723; Tue, 05 Mar
 2024 17:22:42 -0800 (PST)
Date: Tue,  5 Mar 2024 17:22:25 -0800
In-Reply-To: <20240306012226.3398927-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306012226.3398927-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306012226.3398927-7-ipylypiv@google.com>
Subject: [PATCH v7 6/7] scsi: aic94xx: Add libsas SATA sysfs attributes group
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>, 
	Xiang Chen <chenxiang66@hisilicon.com>, Artur Paszkiewicz <artur.paszkiewicz@intel.com>, 
	Bart Van Assche <bvanassche@acm.org>
Cc: TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

The added sysfs attributes group enables the configuration of NCQ Priority
feature for HBAs that rely on libsas to manage SATA devices.

Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/scsi/aic94xx/aic94xx_init.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index 8a3340d8d7ad..ccccd0eb6275 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -14,6 +14,7 @@
 #include <linux/firmware.h>
 #include <linux/slab.h>
 
+#include <scsi/sas_ata.h>
 #include <scsi/scsi_host.h>
 
 #include "aic94xx.h"
@@ -34,6 +35,7 @@ MODULE_PARM_DESC(use_msi, "\n"
 static struct scsi_transport_template *aic94xx_transport_template;
 static int asd_scan_finished(struct Scsi_Host *, unsigned long);
 static void asd_scan_start(struct Scsi_Host *);
+static const struct attribute_group *asd_sdev_groups[];
 
 static const struct scsi_host_template aic94xx_sht = {
 	.module			= THIS_MODULE,
@@ -60,6 +62,7 @@ static const struct scsi_host_template aic94xx_sht = {
 	.compat_ioctl		= sas_ioctl,
 #endif
 	.track_queue_depth	= 1,
+	.sdev_groups		= asd_sdev_groups,
 };
 
 static int asd_map_memio(struct asd_ha_struct *asd_ha)
@@ -951,6 +954,11 @@ static void asd_remove_driver_attrs(struct device_driver *driver)
 	driver_remove_file(driver, &driver_attr_version);
 }
 
+static const struct attribute_group *asd_sdev_groups[] = {
+	&sas_ata_sdev_attr_group,
+	NULL
+};
+
 static struct sas_domain_function_template aic94xx_transport_functions = {
 	.lldd_dev_found		= asd_dev_found,
 	.lldd_dev_gone		= asd_dev_gone,
-- 
2.44.0.278.ge034bb2e1d-goog


