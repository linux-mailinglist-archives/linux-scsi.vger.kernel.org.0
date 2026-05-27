Return-Path: <linux-scsi+bounces-24127-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIrIIoS0FmokogcAu9opvQ
	(envelope-from <linux-scsi+bounces-24127-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 27 May 2026 11:08:20 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD975E1888
	for <lists+linux-scsi@lfdr.de>; Wed, 27 May 2026 11:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2503A302BA4C
	for <lists+linux-scsi@lfdr.de>; Wed, 27 May 2026 09:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93983C1966;
	Wed, 27 May 2026 09:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fMks0tL0"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4CB39B971
	for <linux-scsi@vger.kernel.org>; Wed, 27 May 2026 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872478; cv=none; b=tdQr8fLM/IrIl3otD1QFsTld6eX2MjlIst+47zspPP7j7yEEHSwAJnd6ix+k2wjhZVvowjfNtk1B/NbovISTG9F/LcEb9d7/tp/F1Aud84KmFjGx4m3KIOjGCpVAp/txBzFUME1FRD17jYQsri3VGguGDh6zf+Q9WM+clHw5RnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872478; c=relaxed/simple;
	bh=zIakLtRd88J1DrmJ1gEk9wg1s4sTUqkng/ETURxy2Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrNPledSonyoIrWIrjW/QLW74dbgTNenTMUCyqKvecDk3GMamlLn6QA9BrtWs9YWGehHd5nUnVioOJ8lq1czOCYOoNOQ8ROqwhmEkfAMJh/28YKGGKeCw9pQbA6T/KutJ9QCoo8NDNhUNxrGD+Q64TQLiJFZERgTHW3NWOUcKnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fMks0tL0; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-44e1ebb3122so6997663f8f.2
        for <linux-scsi@vger.kernel.org>; Wed, 27 May 2026 02:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779872475; x=1780477275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5fO/fKsJiasl7JSSDhtF7tK6F2b8dSFCJErGbD1AKs=;
        b=fMks0tL0gphCHwqCvCmP1DF+srefLV4eBMbLLY4XCGBx03WVnwDY4P4MniJPoj55va
         /WCOgyrrmMWu1gFJLavig0NXSdWMZuIBxfa7lfFXKwWpJGqsA1nCScF7KQaQ4E2ijgJQ
         49VPsCBk0OEZJJ112FX1TQHPvGaFlm+1FafkgmAd72Dagz2lCIBd/28o1E4e/v0VR6lQ
         h6/V6XtAYmfLrREi6XBRgD9BYkjZPBJz8eF78aZOVdIJkLMYOUQ8JMJEwR8Y5bCEHxJt
         4cL22EhF6UdWmfHOVHry1xUNkKuOw8efOfNvWqI9vL1N8hGBbFZX4Tc15GR8iStzmdrD
         92RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779872475; x=1780477275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j5fO/fKsJiasl7JSSDhtF7tK6F2b8dSFCJErGbD1AKs=;
        b=pfZxinjWynKE4stevG599sgi+ZCuzPaBZ64ASVuZiRNfpvjU83wOst+jD4nY7tBKiC
         qEigFS17XiRJR1X3lb3ZT/EPFeLHoWmvKWpItDIgiRaiT/lUKGaYOJMCvanaGv5mqIkt
         r0l6AOf/u01U38gXN2KIFGoK6Z+TKtE+Ke//QJlCeRVxkr0AUet3Atg33RXmCLCk91Le
         TLg2oEUJTLh5uasAjFUq33yybRfREe24tAVRlO4p8F/7tOsmtL4OhuRA0y83HjeylhVk
         wICrMnDgq27XBUAOj/wfxYyPR4PrauqToV5x3hITMVvyDlC9Cq0fRvuEbH5INEaVy58M
         PQuw==
X-Forwarded-Encrypted: i=1; AFNElJ9Wx4LmW8X/Fb8Myn6ai2KTPn49u3popqYiaND1wHTAYZmMhTblhxyNlMgaUR5z3cQjr84I1jmRdiYp@vger.kernel.org
X-Gm-Message-State: AOJu0YyMTJYWFaFFn0VWJUE4JhJC+O6nWLSvv3DNhPndueqT5eJcNFPy
	euOX1pyW9BH9clwu7GpmYq2f8CtVFHSpb7zELZPqLpNVAfVOpTHt6ZCtkgr1p2ETNdo=
X-Gm-Gg: Acq92OHTjS0N6w0jGde/zcXCKKD63mXrxiXkGxrjrXhGrnppGJKv3h7SsvNi+RdYHkP
	zM9GCyWp4fCiXhnDiFwqSEjXpp1C3Gw+U50poHE9iAFnhBIJ4JoxPdnAShL2dgJE87K8y1MrDdM
	I7P9CPZVkC3sor6BOCdKy2+3UI6PTbp+li58a/U2X5vUuwiHh0nip6HXKY2JfhFC4Gcx8VXQqPo
	lbH+juoA2n/GCPg2BkFa04fR0nuhyMEi0yKePARZivbXLH12pLPpr12dfqs1EGfXJ/+eCrjcQ4M
	zrS3iUhC9YU6aN1LTb5P9OZheibY3F6WavmvOp3mctvYAH1T+WoN/xSA+mD2Xg0UWq2X/FP+s2E
	t2xqNSRgr/pJSfA5ycXlJKu5GLLvj0tqwTpIu5o7TzvPzi1HcHvKksJ4/41IpjaYDkznWTj+2ZK
	OJgkKMPt48BflXJqcdxZ2cIRNyDw==
X-Received: by 2002:a5d:6f18:0:b0:449:acdb:3009 with SMTP id ffacd0b85a97d-45eb38a83bbmr38255089f8f.6.1779872475540;
        Wed, 27 May 2026 02:01:15 -0700 (PDT)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5b314dsm4062382f8f.30.2026.05.27.02.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 02:01:15 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: kartilak@cisco.com
Cc: adakopou@redhat.com,
	aeasi@cisco.com,
	arulponn@cisco.com,
	dan.carpenter@linaro.org,
	djhawar@cisco.com,
	gcboffa@cisco.com,
	hare@kernel.org,
	jejb@linux.ibm.com,
	jmeneghi@redhat.com,
	lduncan@suse.com,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com,
	mkai2@cisco.com,
	revers@redhat.com,
	satishkh@cisco.com,
	sebaddel@cisco.com,
	Marco Crivellari <marco.crivellari@suse.com>
Subject: Re: [PATCH 06/13] scsi: fnic: Add the NVMe/FC transport path
Date: Wed, 27 May 2026 11:00:50 +0200
Message-ID: <20260527090050.123291-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521180458.5448-7-kartilak@cisco.com>
References: <20260521180458.5448-7-kartilak@cisco.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24127-lists,linux-scsi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: DFD975E1888
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

>+	fnic_cmpl_queue =
>+		alloc_workqueue("fnic_cmpl_wq", WQ_HIGHPRI | WQ_MEM_RECLAIM, 0);
>+	if (!fnic_cmpl_queue) {

Please note that this workqueue should specify one among WQ_PERCPU or
WQ_UNBOUND. If it must be per-CPU for performance reasons or locality
requirements (eg. per-CPU variables), use WQ_PERCPU explicitly.

Thanks!


