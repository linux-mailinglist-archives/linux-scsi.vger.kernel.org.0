Return-Path: <linux-scsi+bounces-765-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC6180A37C
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Dec 2023 13:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68454281850
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Dec 2023 12:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2374C6FD3
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Dec 2023 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="GK8Jj26t";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="FGCpsvn3"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9D219AA;
	Fri,  8 Dec 2023 02:39:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1702031988; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XQLkyYB9v9tytI2kApw55WwMrqWvRp0HtsCne9Qw0yHkqcRp2AAry7R5TjHtTvQx9I
    wl3l2ATQWS1tjOhHUuo4f840aFKJ+7ZuUnTVFvgIM4zNxL98uj9EUUuSDsDHvxV82/wB
    2JLWXgOGMuaeXwBsVre/AzrHm56NTPMqQ0rIaIgB6VLanbiRhF3rya1T0baHKeHF425m
    NsPH9/WRgI+los08FNWGyWuIADO5JroOygrQAzVRkOMAtptqnkcAZJ5QmieB8PqDUz7K
    UX17tnZQj/0Jt8sxpXrqfQjGyKSSG4j/E6pEM8q5LRjHoeS5yJ8on7MV+cTUzT2De0pq
    2iWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1702031988;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=OrWD30iWehTxBVGJryNXXCaLkTyI5f4JdUovjWmK+BU=;
    b=CR5aR2OFeWFdKcDKmb25cAOHmW77237JuVdyRPzfBvJd6O4bw5H3ycNrktQ7LwhaZ9
    8Gl69sBJvkz9fMEbg35k90NKojFK07/YWtAsKl2Bqo8C/U6yOVZ3qAYYeXMHIVn6bPI9
    PdLUYPwySV3E8liBTj0s6HaWyMpOPMqWJTqA5sdGQvRvd+hICVf9+0eKcYMG13dKd8UB
    SKrydPry6a2CVCLbXxuvdmf0FCSxpeBBMK25sRGWt6FT9qyg0MarUhuf5CYdr31uCJM1
    QFwDWJzPayzwh9L+XVnEpUAn/mo/OESqRJOIQTUiCYcg5y0XtQrjsLs0Ob3HprxaIkxd
    +u7w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1702031988;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=OrWD30iWehTxBVGJryNXXCaLkTyI5f4JdUovjWmK+BU=;
    b=GK8Jj26tyy5Pqe6uih7a2Prw/OvZ4kX5G2ojKxhynJvZTtBCaKr/q+hV15F6lCnMm1
    bxSJ0vFz4bs+6fYBRrfKKz0QDvX10TVlALvHuBQ6XjyjrAaZRsRGFlRN3bnAmeSZhf8f
    FECaMHkqHpNN9eOQsnqQ3oSVSKGXY0y3uBkCAOzPT54ZmkR6jOwomNdEJMhfoPi+S3yP
    udTDNB50O+rAgEgvIMMNdjBzKJvWU5rH8OPx1YJYudYaXRrMOi/4sGdS+DhQnh3YradV
    snb4GyMi/+0XjdCl3buGICtHrC01W1MNmLJAc3x3bVngkWD0kdAY6ag3e1qcFj2fFM4z
    XPaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1702031988;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=OrWD30iWehTxBVGJryNXXCaLkTyI5f4JdUovjWmK+BU=;
    b=FGCpsvn3533KqHxLTGECm6tzGoNGCdC3GRmwe5I/W7YLqsplkRjZSN4hUqYbM3g4Mw
    oLjTnR9ppqFnhjRu6FDA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD2QzemV2tdlNlNRZBXiUw="
Received: from Munilab01-lab.micron.com
    by smtp.strato.de (RZmta 49.10.0 AUTH)
    with ESMTPSA id z4c2a6zB8AdlBb3
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 8 Dec 2023 11:39:47 +0100 (CET)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	bvanassche@acm.org,
	alim.akhtar@samsung.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	mani@kernel.org,
	quic_cang@quicinc.com,
	quic_asutoshd@quicinc.com,
	beanhuo@micron.com,
	thomas@t-8ch.de
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mikebi@micron.com,
	lporzio@micron.com,
	Bean Huo <beanhuo@iokpp.de>
Subject: [PATCH v4 0/3] Add UFS RTC support
Date: Fri,  8 Dec 2023 11:39:37 +0100
Message-Id: <20231208103940.153734-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Adding RTC support for embedded storage device UFS in its driver, it is
important for a few key reasons:

1. Helps with Regular Maintenance:
The RTC provides a basic way to keep track of time, making it useful for
scheduling routine maintenance tasks in the storage device. This includes
things like making sure data is spread
evenly across the storage to extend its life.

2. Figuring Out How Old Data Is:
The RTC helps the device estimate how long ago certain parts of the storage
were last used. This is handy for deciding when to do maintenance tasks to
keep the storage working well over time.

3. Making Devices Last Longer:
By using the RTC for regular upkeep, we can make sure the storage device lasts
longer and stays reliable. This is especially important for devices that need
to work well for a long time.

4.Fitting In with Other Devices:
The inclusion of RTC support aligns with existing UFS specifications (starting
from UFS Spec 2.0) and is consistent with the prevalent industry practice. Many
UFS devices currently on the market utilize RTC for internal timekeeping. By
ensuring compatibility with this widely adopted standard, the embedded storage
device becomes seamlessly integrable with existing hardware and software
ecosystems, reducing the risk of compatibility issues.

In short, adding RTC support to embedded storage device UFS helps with regular
upkeep, extends the device's life, ensures compatibility, and keeps everything
running smoothly with the rest of the system.

Changelog:
	v3--v4:
		1. Incorporate a check for "Current time precedes previous setting" in ufshcd_update_rtc()
		2. Eliminate redundant return value code in ufshcd_update_rtc().
        v2--v3:
                1. Move ufshcd_is_ufs_dev_busy() to the source file ufshcd.c in patch 1/3.
                2. Format commit statement in patch 2/3.
        v1--v2:
                1. Add a new patch "scsi: ufs: core: Add ufshcd_is_ufs_dev_busy()"
                2. RTC periodic update work is disabled by default
                3. Address several issues raised by Avri, Bart, and Thomas.

Bean Huo (3):
  scsi: ufs: core: Add ufshcd_is_ufs_dev_busy()
  scsi: ufs: core: Add UFS RTC support
  scsi: ufs: core: Add sysfs node for UFS RTC update

 Documentation/ABI/testing/sysfs-driver-ufs |   7 ++
 drivers/ufs/core/ufs-sysfs.c               |  31 +++++++
 drivers/ufs/core/ufshcd.c                  | 103 ++++++++++++++++++++-
 include/ufs/ufs.h                          |  15 +++
 include/ufs/ufshcd.h                       |   4 +
 5 files changed, 156 insertions(+), 4 deletions(-)

-- 
2.34.1


