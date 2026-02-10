Return-Path: <linux-scsi+bounces-20753-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OeqLAOFimnoLQAAu9opvQ
	(envelope-from <linux-scsi+bounces-20753-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Feb 2026 02:08:19 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 373CA115EAB
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Feb 2026 02:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35331301A7CC
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Feb 2026 01:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BB922A4CC;
	Tue, 10 Feb 2026 01:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1GID2+lb"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAF417BEBF
	for <linux-scsi@vger.kernel.org>; Tue, 10 Feb 2026 01:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770685695; cv=none; b=jptem+ppZcQe1GnWjsJQ9fvG/rD9uWBHHLRGjBmLs6osNmyLRKJ6KGJ5I13yUqCspBG1juYAhITok8PJMWEc3FBxfhSvi2Rm0dnnyyVEemNYx/u2U778iGbQ9MZCYs6uJQx0ABs/hlxbdWrEoAzkb4H44O5Dq1TqRB7GPSMkNlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770685695; c=relaxed/simple;
	bh=qpRqxBhJqfNMX9A+JU9YKQsGjcp3vWVpz1Vcgm0lPzg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ah/VYQ1Th5e+NmcONmaBJRCaLnRLZ3jOajn2cSxB8MTYYSk+vHts/VulIKJ9xX2lSy7rAuerb70W9ZlYuNxXnMYNyU9PY7Z+FTgsbdf+420iRMMpI+rXHlPc1equEYN6id/sqZCQscswT2rt6H4N2jc+UGgNti9uHflITAZGw/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--salomondush.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1GID2+lb; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--salomondush.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so206318eec.0
        for <linux-scsi@vger.kernel.org>; Mon, 09 Feb 2026 17:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770685693; x=1771290493; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w81+u8wZURYMASLY8btCbrkOihzDHCsC71pJaMA3O7w=;
        b=1GID2+lbzTxrCdiOIxImfB4Lu03wuEi0SnP9MOGMgwqBF2G70lbbotsU+2ZAmhM29U
         wT6+k/EXYm6wtVIoyGGtY7D8U7KojAdJ0b5tDxRBYxwbeY608lN2DBB/l75n9+Q4f0Tf
         xet4xepvnm8euPBLo9sbM0H/UfBiOdywlkhE7cFNkXLcwGxosTYn3QEkgInlWuVcYhUG
         N/iZoyGFb0WJa/FAWv/94s8GYWj31f23ARa8q1qh16Z4+ubrTEXN/CHb0NUxJmNK5jQa
         AlhnkaAoKQGtj0+nIlkAIepGoX/mjDq6o5g7Y62OGGUqAek2MWi+F3Kv9Dwitg9z/8yg
         xcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770685693; x=1771290493;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w81+u8wZURYMASLY8btCbrkOihzDHCsC71pJaMA3O7w=;
        b=BZejK+3qWP1wto/sor130MOUfgN0e3muohlvHLdaF+L5ETXu4eOSdlbCUs2/IdtCUY
         dQHG3eJjtae8x9PmuyHJcJh2HE5IMiSFpLIwDQ7JrnAlduifHHhEpeTa6ETboCsAyJwf
         pMwAb505OPqQFbqab5a1cpJ/394I13y49DKgsgBVK4zu/8o1cuntIpxAYvgn9Oj/9J7r
         L/NjEU8Dcz4zhtITtJBUsE9bXY2fvqiVHmHLBcAwxO0O1rLpoZ+VwjmaXx64vnh2EcHA
         9Q24Z8aCNhoCVsdNezEHDiZUTOsUQHoqaQ0pJVsD/WTX0NX8A2FvaQwu53A+USH+Wt7k
         c+3w==
X-Forwarded-Encrypted: i=1; AJvYcCV+tKrzZDIYuQzUxF8X03B/oeN9B4ZtisMl0tt5ObamDnlE7Mcq8qChDR0Mupe50I9KD8On0n6zeCT8@vger.kernel.org
X-Gm-Message-State: AOJu0YzVDEpK9olO7FkIWgwJDyWWTrS0yrXw20IRKMX05zaHkJhONBj1
	+DPCdtsvDJlFtk3Q8p0cYQ/WIK7clbD1SGzdkcyo7GPNygPTaAyepesmv/2jT9mYUrIDcRwj5wC
	F3loEsYB/KpIzDZZnbUYrgI8ZrQ==
X-Received: from dyrz4.prod.google.com ([2002:a05:7300:8c04:b0:2ba:7ace:1fb7])
 (user=salomondush job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:3242:b0:2b8:26b8:3436 with SMTP id 5a478bee46e88-2b85647b1d5mr4701326eec.10.1770685692769;
 Mon, 09 Feb 2026 17:08:12 -0800 (PST)
Date: Tue, 10 Feb 2026 01:07:54 +0000
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260210010754.1824914-1-salomondush@google.com>
Subject: [PATCH] scsi: pm8001: Fix use-after-free in pm8001_queue_command()
From: Salomon Dushimirimana <salomondush@google.com>
To: Jack Wang <jinpu.wang@cloud.ionos.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>, John Garry <john.g.garry@oracle.com>, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Salomon Dushimirimana <salomondush@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20753-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[salomondush@google.com,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 373CA115EAB
X-Rspamd-Action: no action

Commit e29c47fe8946 ("scsi: pm8001: Simplify pm8001_task_exec()")
refactors pm8001_queue_command(), however it introduces a potential
cause of a double free scenario when it changes the function to return
-ENODEV in case of phy down/device gone state.

In this path, pm8001_queue_command updates task status and calls
task_done to indicate to upper layer that the task has been handled.
However, this also frees the underlying sas task. A -ENODEV is then
returned to the caller. When libsas sas_ata_qc_issue receives this error
value, it assumes the task wasn't handled/queued by LLDD and proceeds to
clean up and free the task again, resulting in a double free.

Since pm8001_queue_command handles the sas task in this case, it should
return 0 to the caller indicating that the task has been handled.

Fixes: e29c47fe8946 ("scsi: pm8001: Simplify pm8001_task_exec()")
Signed-off-by: Salomon Dushimirimana <salomondush@google.com>
---
 drivers/scsi/pm8001/pm8001_sas.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index 6a8d35aea93a..0285ce6400dc 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -525,8 +525,8 @@ int pm8001_queue_command(struct sas_task *task, gfp_t gfp_flags)
 		} else {
 			task->task_done(task);
 		}
-		rc = -ENODEV;
-		goto err_out;
+		spin_unlock_irqrestore(&pm8001_ha->lock, flags);
+		return 0;
 	}
 
 	ccb = pm8001_ccb_alloc(pm8001_ha, pm8001_dev, task);
-- 
2.53.0.rc2.204.g2597b5adb4-goog


