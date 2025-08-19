Return-Path: <linux-scsi+bounces-16297-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA1EB2CD13
	for <lists+linux-scsi@lfdr.de>; Tue, 19 Aug 2025 21:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9E42A12A2
	for <lists+linux-scsi@lfdr.de>; Tue, 19 Aug 2025 19:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72ECF3376A8;
	Tue, 19 Aug 2025 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="o58sL9wK"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59AF2773C1
	for <linux-scsi@vger.kernel.org>; Tue, 19 Aug 2025 19:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755632327; cv=none; b=DuLS4u/f3ciLgDAZp06BhjmEpbHmtaBXU/e6APGGOkoOGdz00JeQybDW9xKxiZ693gsBCOoSZ5POX1wYc8YQO4T2ThkPForP9Ue0uem93L9+sJHVgw7AMV/6W4Jr60+sIIa0XP2s9R1cY1M5Rqvu7In7PMedEfovXdkc+GWU2zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755632327; c=relaxed/simple;
	bh=PpZzl8a7fk1oI5jCdrUahTW65txjxjks+SfFA3bh1io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QzX1fN+wWYWQUTMrB8f1PweoG+MPONlvgd+NM3O9V3bRQeNwdYqsIlYmxIOFrh36jQdejunAVMJPlNlsvUxMoC4vJZlQevwkH6RzKoCLsE5VvBQVR2L7A+gObI+wbN+dlIcO28bi+2GdmiRW9EodtHgG4NpDA+nW/YdGohXA68s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=o58sL9wK; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4c60J46h35zm1745;
	Tue, 19 Aug 2025 19:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1755632323; x=1758224324; bh=PpZzl8a7fk1oI5jCdrUahTW6
	5txjxjks+SfFA3bh1io=; b=o58sL9wK2egdqSWSjP+FyRoWCG/snp+UNpppEtyv
	nQvKjefA5O5azvjRS5mK3eClOqhyJm8UJbqRlw/+bd/eOf5cwbinDogBbDwzbVfZ
	T3NECmVSjKLtb4usc6P+WOixGSXDB0i9PnwfBIbYdmMHXUz5YpZxutP+8RbkUFhv
	NEE839OuaH8HOgOg+hP8vGbP5wsTYptaW+NFC0lADLuIpU/Qg42kKUHRqpuwg9HT
	e0xMKX72k5spnoWLrgOVDx/fNjriqw8WYmB85Qb7hRGVgwnGnWrNx6AeWMg8levW
	k9EEyHfuFnk1nfeD+QLqgz8Tm0B81v/HW155LODEPOVHeA==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id FWrxw3am1b0V; Tue, 19 Aug 2025 19:38:43 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4c60J04324zm1742;
	Tue, 19 Aug 2025 19:38:39 +0000 (UTC)
Message-ID: <881cf485-6405-4fbf-9228-7b6acc3241f0@acm.org>
Date: Tue, 19 Aug 2025 12:38:38 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] scsi: sd: Remove checks for -EOVERFLOW in
 sd_read_capacity()
To: "Ewan D. Milne" <emilne@redhat.com>, linux-scsi@vger.kernel.org
Cc: michael.christie@oracle.com, dgilbert@interlog.com, dlemoal@kernel.org
References: <20250815211525.1524254-1-emilne@redhat.com>
 <20250815211525.1524254-6-emilne@redhat.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250815211525.1524254-6-emilne@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/25 2:15 PM, Ewan D. Milne wrote:
> Remove checks for -EOVERFLOW in sd_read_capacity() because this value has not
> been returned to it since commit 72deb455b5ec ("block: remove CONFIG_LBDAF").

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

