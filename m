Return-Path: <linux-scsi+bounces-11060-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B693D9FF804
	for <lists+linux-scsi@lfdr.de>; Thu,  2 Jan 2025 11:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E7A3A2123
	for <lists+linux-scsi@lfdr.de>; Thu,  2 Jan 2025 10:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A9B1A8F83;
	Thu,  2 Jan 2025 10:29:10 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CC7190485
	for <linux-scsi@vger.kernel.org>; Thu,  2 Jan 2025 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735813750; cv=none; b=PWVlv7i0f9CWyrktsDP/upMneIFaNe7YyYd3ngxg5qGWv4DSdsfAMSuEnRdOKFHZQj2V2UVs90G110+++fysBRRtS0irTNxfXmGn6dypyK+8gdpaEjQuHysAKHIH+Ytpu5CT5HZ7GZb/P+YXFQtxrQZrjcJP4XzbP5ZwD1gk//Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735813750; c=relaxed/simple;
	bh=Vx5GO7PyIWzEGTIeSdDqDqz7LuV7VBS9VwqozIFlvAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xxu7Kt7vHn9GifE+0fVLfG8wsiae/z6qPQb0qHrGdD9Br3TAJVSzqYseI3y4IJw8MK6Kwrpz0zBVFfRC131BdMOn/IZSkDB1uuXLLzVnXTuoPWlTIntG/hExiQBydNOCKIWWiDM/RWmFwlV4XQnncwrjMfl9juODlaa05KoIKTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.128])
	by sina.com (10.185.250.22) with ESMTP
	id 67766A4A00003252; Thu, 2 Jan 2025 18:28:28 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6959147602503
X-SMAIL-UIID: 5DD46E63FE364BF6A7A4FFFE105F2AFC-20250102-182828-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+566d48f3784973a22771@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [scsi?] possible deadlock in sd_remove
Date: Thu,  2 Jan 2025 18:28:15 +0800
Message-ID: <20250102102816.1261-1-hdanton@sina.com>
In-Reply-To: <6773a494.050a0220.2f3838.04da.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 31 Dec 2024 00:00:20 -0800
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    573067a5a685 Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a09818580000

#syz test: https://github.com/ming1/linux v6.13/block-fix

