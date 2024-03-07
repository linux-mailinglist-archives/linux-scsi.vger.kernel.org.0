Return-Path: <linux-scsi+bounces-3081-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1649187599E
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Mar 2024 22:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0741281457
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Mar 2024 21:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B386913B7A2;
	Thu,  7 Mar 2024 21:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x0fQATCa"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC42613B787
	for <linux-scsi@vger.kernel.org>; Thu,  7 Mar 2024 21:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847866; cv=none; b=iFadPZpefjf8yEpnNJsofr1W1z+hN3/Um490+KwjorqwpZ6fc4o+PCpmB7m+rOn4p0HgJIJga5lDAHjJ4PC1lUDPa20it7mmYa6Z0UlPO4XQczqQvajfVM8GOzyw9bELNI1Jvkf/hwZi3g9Edi7927Ttb/dKX6BUb/ona9iQMQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847866; c=relaxed/simple;
	bh=M62EQM6U0bYHC2ib0ARad2o5Cl4uV18bHfOcKuqAYt4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tnQcagha5AOA24h6avqbZrRkr3Pznza8hqtHT7bqdzlzgcbTyQxcoavk8qNS4jFYJYabu2FgtQPSpEWn8zM5znoBMKq2EcHpahlNQ9eYzUACsusmTulx6qPtrX52agjNv4Ry0+WmfL1yq7GSCMPz+NezgmQkistbNIqSM05Uawc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x0fQATCa; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609fe93b5cfso4119997b3.0
        for <linux-scsi@vger.kernel.org>; Thu, 07 Mar 2024 13:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709847864; x=1710452664; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x1NFN1gWITL3fejFzZxqrofHlY2o+SfOK+4pQW+/66s=;
        b=x0fQATCaRPpTvZ7rVTyVdDUB2Ou9DZv9cnw2c5Q/lGkXKZz7BN2bJTUQ4wn8eS57nk
         Tx2Pr8gaAgd90n34uTO49xB4O4ZxBPcHZOV8iNxT544+tXIcDvOpJPCHQXJlX8tH9yjL
         YHKVdosyDaSQxL9lz1bUw1SUKlmXWyMpbmnFHNMrwUU89YKt/83o+8KM8hnUoikfo6G6
         gJ94DMtVJMZKxnTe64UazOMvDazlgIIk1k05pCMNvcaSRi5ADKvCiQscEcHUYzP25uTE
         u/rR65gMUFnTipx5fcDaFrf1WfzgqseRPxt09YFKhbpaWPjiPwjsH+UziEtRl5wCMETp
         M64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709847864; x=1710452664;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x1NFN1gWITL3fejFzZxqrofHlY2o+SfOK+4pQW+/66s=;
        b=IUDw14ny7beNTsKaQ+mI/X5QcMUY4Lvr6DE1Vl+kBsBzOye0JThoGdwUmOoQxruuEf
         7IrLXX1Ee89kjmBVKYr0Rf99bTBGJjwdpyaAAr4j7q4k8Tk8Xu4tDhKsTV1FJbyHTQXI
         l8oMpdzSDiawVol5FQVqQhzS1gDd4uEorzcKLgxI+SLYMQYAB3POXNcQLT4aFOjly77Z
         iWYXNKaMO+SPmUZRqZYOUmTLsNxcDW9iH1nUESwQt5k88Jrim5C03+wJzrb3J4EVxw90
         0PbsA6LvRzIh+4/clgft7GU0BjEPZnPUoUFkPfqA+OtVpM0q44h8MEPYYPjRRmlGF/yi
         gfKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnMNFybajHuBeKOCa4pLir1vHAhqRl6YXnqBrYvBKj709uYG8cEDnHRALYHCMAeNiP/myFjhzA3o7oQGLdveHmXgfs9RIFmYSu5Q==
X-Gm-Message-State: AOJu0YwAJlIv5d80AldZo9nKhdzBsaeMfQBuSEvLyowgB0e5/+Zo5RFN
	ZZcGL2vM9iyjjojZtNjtkx474iGHlxAria53fQvmNxPEZUvpPxIokpgDSDX2Jve7fGZWjIM+o78
	g74hRCem1sA==
X-Google-Smtp-Source: AGHT+IFvCq/wXgnoeop8+efjFSjJ2/ZOGIvu5RSKi6WLFGS+IxG2BlkyC04dawynR8bpt3xA+5Q7BmtYguEX+A==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:69c0:c447:593d:278c])
 (user=ipylypiv job=sendgmr) by 2002:a81:5758:0:b0:609:1fd9:f76 with SMTP id
 l85-20020a815758000000b006091fd90f76mr4323813ywb.0.1709847863862; Thu, 07 Mar
 2024 13:44:23 -0800 (PST)
Date: Thu,  7 Mar 2024 13:44:11 -0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307214418.3812290-1-ipylypiv@google.com>
Subject: [PATCH v8 0/7] NCQ Priority sysfs sttributes for libsas
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

This patch series adds ncq_prio_supported and ncq_prio_enable sysfs
attributes for libsas managed SATA devices. Existing libata sysfs
attributes cannot be used directly because the ata_port location is
different for libsas.

Changes since v7:
- Dropped the WARN_ON_ONCE(!dev_is_sata(ddev)) checks from sas_ncq_prio_*
  sysfs functions. The is_visible() callback hides the corresponding sysfs
  attributes from userspace for non-SATA devices.
- Added missing "Return" descriptions to ata_ncq_prio_* kdocs.
- Updated the commit message of the "ata: libata-sata: Factor out
  NCQ Priority configuration helpers" patch with the explanation
  why spin_lock_irq() was changed to spin_lock_irqsave().
- Restored blank lines between spin_unlock and return in ata_ncq_prio_*
  helpers.
- Updated the commit message of the hisi_sas patch to indicate that
  hisi_sas_v1_hw.c was not modified because v1 HW does not support SATA.

Changes since v6:
- Replaced sas_ata_sdev_attr_group definition with a macro for
  the "CONFIG_SCSI_SAS_ATA is not set" case. The macro defines
  an empty rvalue struct eliminating the variable definition.

Changes since v5:
- Added __maybe_unused attribute to sas_ata_sdev_attr_group to prevent
  an unused-const-variable warning when CONFIG_SCSI_SAS_ATA is not set.

Changes since v4:
- Updated sas_ncq_prio_* sysfs functions to use WARN_ON_ONCE() instead
  of WARN_ON().

Changes since v3:
- Changed ata_ncq_prio_supported() and ata_ncq_prio_enabled() to store
  the result into a boolean variable passed by address.
- Removed the "usable with both libsas and libata" wording from
  ata_ncq_prio_* helper's function comments.
- Removed the unlikely() in ata_ncq_prio_enable() because the function
  is not in a fastpath.
- Dropped hisi_sas v1 HW driver changes because it doesn't support SATA.

Changes since v2:
- Added libsas SATA sysfs attributes to aic94xx and isci.

Changes since v1:
- Dropped the "sas_" prefix to align sysfs sttributes naming with AHCI.
- Dropped ternary operators to make the code more readable.
- Corrected the formatting %u -> %d in sysfs_emit().
- Changed kstrtol() to kstrtobool() in [ata|sas]_ncq_prio_enable_store().
- Changed comments to use the "/* */" style instead of "//".
- Added libsas SATA sysfs attributes to mvsas and hisi_sas.
- Dropped the 'Reviewed-by' tags because they were not sent in-reply
  to the patch emails.

Igor Pylypiv (7):
  ata: libata-sata: Factor out NCQ Priority configuration helpers
  scsi: libsas: Define NCQ Priority sysfs attributes for SATA devices
  scsi: pm80xx: Add libsas SATA sysfs attributes group
  scsi: mvsas: Add libsas SATA sysfs attributes group
  scsi: hisi_sas: Add libsas SATA sysfs attributes group
  scsi: aic94xx: Add libsas SATA sysfs attributes group
  scsi: isci: Add libsas SATA sysfs attributes group

 drivers/ata/libata-sata.c              | 160 +++++++++++++++++++------
 drivers/scsi/aic94xx/aic94xx_init.c    |   8 ++
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |   6 +
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |   6 +
 drivers/scsi/isci/init.c               |   6 +
 drivers/scsi/libsas/sas_ata.c          |  82 +++++++++++++
 drivers/scsi/mvsas/mv_init.c           |   7 ++
 drivers/scsi/pm8001/pm8001_ctl.c       |   5 +
 drivers/scsi/pm8001/pm8001_init.c      |   1 +
 drivers/scsi/pm8001/pm8001_sas.h       |   1 +
 include/linux/libata.h                 |   6 +
 include/scsi/sas_ata.h                 |   6 +
 12 files changed, 256 insertions(+), 38 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


