Return-Path: <linux-scsi+bounces-15447-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAEFB0EE29
	for <lists+linux-scsi@lfdr.de>; Wed, 23 Jul 2025 11:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC283AA515
	for <lists+linux-scsi@lfdr.de>; Wed, 23 Jul 2025 09:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7A727FB25;
	Wed, 23 Jul 2025 09:14:48 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6887F1F94A;
	Wed, 23 Jul 2025 09:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753262088; cv=none; b=IsWaNNm6YkL4lhaZtK0LmJcUYpNnTlSIlZd/dl6irlivENfrf8Xli1ArNbXPOyf9QZOHoUO8VKKb44Rj0SWjNSTZI3ts4dqFXHNARmcIU9DbQaWW/SO5R3YDvapkYiPxKmA84+ktwQiRmwxIq5g8ghKQdPpwU99e4UmvqKDi+w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753262088; c=relaxed/simple;
	bh=rPhPK6zuuVSnZKNZjdzR9QjKlbu3GbjpaGaAKk922hI=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Uq66N6QhzGs0GItS7DAk9AnYlgUBBsS5Iz5o+TlmoZxz2v1AgNE07UR0dYYpMnVnH2uSASBOO3yR6PLV8KR3Ypr7pwAGrLYUNL4rlhO7a7epoE3vdm0XnmRaTZmkBGggGLqQrLwNbzp+dLx5d8EjK0L0fValbFvOrjnv4jO3pow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bn7cv639Wz14Ltl;
	Wed, 23 Jul 2025 17:09:51 +0800 (CST)
Received: from kwepemh200005.china.huawei.com (unknown [7.202.181.112])
	by mail.maildlp.com (Postfix) with ESMTPS id BFCD31401F3;
	Wed, 23 Jul 2025 17:14:41 +0800 (CST)
Received: from [10.67.120.126] (10.67.120.126) by
 kwepemh200005.china.huawei.com (7.202.181.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 23 Jul 2025 17:14:41 +0800
Subject: Re: [PATCH] scsi: MAINTAINERS: Update hisi_sas entry
To: "Martin K. Petersen" <martin.petersen@oracle.com>, Yihang Li
	<liyihang9@h-partners.com>
References: <20250702012423.1947238-1-liyihang9@h-partners.com>
 <yq1ms967jj5.fsf@ca-mkp.ca.oracle.com>
CC: <James.Bottomley@HansenPartnership.com>, <linux-scsi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<liuyonglong@huawei.com>, xuwei 00615891 <xuwei5@huawei.com>
From: Yihang Li <liyihang9@huawei.com>
Message-ID: <09fe7faa-cae5-6dff-4f35-2c2744c73cc0@huawei.com>
Date: Wed, 23 Jul 2025 17:14:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <yq1ms967jj5.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemh200005.china.huawei.com (7.202.181.112)

CC hisilicon SOC maintainer: xuwei5@huawei.com

On 2025/7/15 1:52, Martin K. Petersen wrote:
> 
> Hi Yihang!
> 
>> liyihang9@huawei.com no longer works. So update information for hisi_sas.
> 
> In situations where affiliation changes it is customary to receive an
> acknowledgement from the institution which previously held the
> maintainership.
> 

