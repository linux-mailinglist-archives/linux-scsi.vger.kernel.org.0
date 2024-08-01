Return-Path: <linux-scsi+bounces-7067-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C704A945292
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2024 20:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D752855C3
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2024 18:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3E61422DE;
	Thu,  1 Aug 2024 18:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIIUAFJB"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39A0182D8;
	Thu,  1 Aug 2024 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722535850; cv=none; b=pwZkYqzC1eB2NCt47Uu3yD7hAAMmW86WgoO4QjS3PB6/51e2PEcXbQLYuICLP3V5mMcDkxS55EClbNLOTg4lQQmhiL6Z7LyEUxOUYapOH+Z8+WTW/2Flu69fltucJvl2Es6e0k2SRUfEpmN6UOseS8qqdMLNG9hPIs7Gjetd9OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722535850; c=relaxed/simple;
	bh=71kV20FqY4Ai8IF+fb62AaJM3opVatT4U0WLYn/1oPQ=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YEH+GAv0wiAyfu1yBloEZAp7dIdJrHpDnghaoz+ClI58b6ju5s/uwgtlJLFrnB26Jcz+tUUkq0Xxkrod3qRhuEhhv+LD118tjIFBUdD8/wvPxttSWTz8AALRzAFHqYwAm9SjMGpDHUwBNpcQt/jYIAwTJmqgDTGbBp3cScoxiY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIIUAFJB; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-530ad969360so3691357e87.0;
        Thu, 01 Aug 2024 11:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722535846; x=1723140646; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwbAy6SukR8Gi4GPcCemCfW3YkpTN/hdOKxzKRofd5w=;
        b=YIIUAFJBmbxtKUM9FNcL0gCmvbFNVdo3P6ydSB+X0Bzt3OLOY68eeEQ7MxbvRoNd2f
         NewAqbo4tjzrlxvIGo46i97w2UYnGfJJUeyumL4Nf6+xboXeWaqwXsSxDMVUkBJxof5j
         MCu5Ik/Dt8DRJnHRAqqCVVFtFDqiLEmcSmeRXhACPnv2A8Z6iZy6/bHhIr6rL511tmg3
         6W/ljAimdjrXiporBoxVP3V8F0Je+chw2GFXHRmb1QYeayZpT3uA0Pm6qLa0TYaDAnMi
         3LgkwDbBSCAiwHSa3LnvXY8flU30PSFzYXac6rIXpxmamY/ejLBhPC6mfPqZmkQI3QOs
         TkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722535846; x=1723140646;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HwbAy6SukR8Gi4GPcCemCfW3YkpTN/hdOKxzKRofd5w=;
        b=SN5b1lVqhb/Y+QbXCqC9KU+70xz/J3XRq8uu+K5L6su4Zq6hP2+I8r2+68GqSsR+bU
         ZxZHQyVSxQ/NwLOamFoLgj2ljGGC896X45Lpqy27hNy1hrGRyuZOXgMO03GxQErhOp0n
         VsyPpPkhzHyqLh/d6sR7Nk9VzgLM6PPKSlZwzfdpuLRDLScT9THEVnKeXu7ETQ9P17hk
         m2nSPHjOF9CQbDG+neFn04WsZYPGeE6RdHMollcl/f2mqGtD5vHe4o9PiAe4MNd3d/eH
         9Bwx6n7hQOzsJMjVplAn9f5bDheSQXxv3r+2/tmzr5dRxU7N0UeDWC+i+IvZ9kX1ZUfs
         Jq1g==
X-Forwarded-Encrypted: i=1; AJvYcCWNdCSQoDlsmsMh/5IgTRcSdJpBPwYET6kMWZHuD/UAO44BDBqdSIn0AQQLQ5tTe7kztUIoqsZnEziv+hftVHyzR5T9twZvXUxvH+qKsVbl7Y8zLTidLMIXnIny8udtnH6zPp+Okg==
X-Gm-Message-State: AOJu0YxWeFd5PkUTLAqxxHWH6+Hjh7+ngMFa46lBYdrQQQ9rTVVWC9gf
	5D35u7apBLr/A2v+IEYkwM0Y0uE1iw4s6rVRlyFTX3rpyH7M1b3+/dRh1Q==
X-Google-Smtp-Source: AGHT+IHLBNMi5F2Jr9+52ewWl5q2smIRUEnmmHxHuu2qkiTTt4qlfWqMQ2xOsUKGHk0QJ74250gnGQ==
X-Received: by 2002:a05:6512:3b06:b0:52c:8aa6:4e9d with SMTP id 2adb3069b0e04-530bb3a220cmr647860e87.29.1722535845483;
        Thu, 01 Aug 2024 11:10:45 -0700 (PDT)
Received: from [192.168.1.105] ([31.173.80.208])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bb9b19ecsm28620e87.0.2024.08.01.11.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 11:10:45 -0700 (PDT)
Subject: Re: [PATCH] ata: libata: Remove ata_noop_qc_prep()
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 John Garry <john.g.garry@oracle.com>
References: <20240801090151.1249985-1-dlemoal@kernel.org>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <2f092091-a2af-d7e3-3634-68536bbe87a9@gmail.com>
Date: Thu, 1 Aug 2024 21:10:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240801090151.1249985-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hello!

   Not sure why you keep leaving me out of CC on the patches that touch
the PATA drivers... :-/

On 8/1/24 12:01 PM, Damien Le Moal wrote:

> The function ata_noop_qc_prep(), as its name implies, does nothing and
> simply returns AC_ERR_OK. For drivers that do not need any special
> preparations of queued commands, we can avoid having to define struct
> ata_port qc_prep operation by simply testing if that operation is
> defined or not in ata_qc_issue(). Make this change and remove
> ata_noop_qc_prep().
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]

MBR, Sergey

