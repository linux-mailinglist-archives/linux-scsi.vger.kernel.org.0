Return-Path: <linux-scsi+bounces-4413-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4CD89E4A1
	for <lists+linux-scsi@lfdr.de>; Tue,  9 Apr 2024 22:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23DB81C2106E
	for <lists+linux-scsi@lfdr.de>; Tue,  9 Apr 2024 20:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192F3158855;
	Tue,  9 Apr 2024 20:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3/LubXYh"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99988158209
	for <linux-scsi@vger.kernel.org>; Tue,  9 Apr 2024 20:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712695504; cv=none; b=t98AMdmhFLHO6aauJl947Pj21TCr7UAaKxgvne8kx6MyfKPPJ0bzCIQQp4lc83rcHo09cd6+6pNQcvoum7rL7wdhXOqXwVQ5ksl1PdUPJ0AdKofjisTBad7m9V2N0FC9x4qhhxhMqDVZ0EouQJEqJb/3Uxs+VrHlXHEZlWID1mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712695504; c=relaxed/simple;
	bh=a7U/KHmJSAC0qS3Nm1s43VAOBejI7+eeUwhheadSBPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E85oJ9NIBMPVrWebCUqFctUubCJzcdaa8MmeEXsczUi70RyFf3SxqMsJq3hrwfEuzFZKrrr6CBPz3jcN1NlKX0px3Yh9iLY90ykTlEW6qkqTAm89+3ztM3kGsSxC3MKdtAHVBsxsKFP6a13X7eQZJsug7FDZ+uNuCMUOVfvpXLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3/LubXYh; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e3c89f3d32so17525ad.0
        for <linux-scsi@vger.kernel.org>; Tue, 09 Apr 2024 13:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712695503; x=1713300303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EJmnxoz+cMpgq0WmNUJv1TqkP9ZYN8EAwfDEGZy9D1Q=;
        b=3/LubXYhgz0gHYIgfEUt4CfEWoWQrlpQJeipMVD1uIx6Pqm6/aqfipeH2dcvp7QY5i
         wCMT2NSyGp1w4EMO1Ps/WIlAe+fiPJ0aXKAW8QcuFyLVln92Z6Yl8lR/xxzvOi7G+7mK
         T5eO42Guec6QMuARutDPfnvc1iA/IZgpzs+2NtkI3m7FjIwm96lf6Is1ur5zf10qnlUv
         D3Ft/G4zcORb2uka5jLk9ct3mUvnbFPZqBFD1soA6j/K7leh43FR9ttBcPEYtQmZSCmx
         qXC0ZOYBIp62FKLhhZ1wRTQHuxHJsevu8wDGqwS31P96unK2dc/RtOp1YQqZ61l8jiHu
         7jzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712695503; x=1713300303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJmnxoz+cMpgq0WmNUJv1TqkP9ZYN8EAwfDEGZy9D1Q=;
        b=nZUDZi5j7riKBc9b3emQ2FdQHgrNlH2O4S4QXvm4+TbutviJE2xzeOUEES4t+s4cti
         lSulhECyxlk29Lv+sKDfHNkFplN4Oecu8U2cX9MPvzqGwWb0qKvay6G5bbccO4m4/mHN
         bScJ35lx1ZCyQlh2t7JH0futgZJSd5hwxP/6mBYQdjHNHNnWqP8NVbY6tCKGLN9FiGb3
         e/TGanR5Y1eT7pKhYhj6VA1KK4Tda8yjHR+2ZO15ly7uBKtcCy01FkSCViXlUc+znwlM
         sT74CLMe09zzS6nz1+GHI1GNQ53tB0bMRv2A/CkCtdXnfA0PMiL/CD085kRy5w7QDvrD
         elcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvLDEkwD4PqvGQwdnzaqLor/TlbW1+dLlhF3UqAJaKKiql3TJAn/DlWn5uhvIXqU//LRPLbHmy1WUcdPDqHKQoaakg3StSgekTwA==
X-Gm-Message-State: AOJu0Ywbi9oZsOJ9SYir/awQguNxV+wNtvovF5oR1nXHcuT5eOCsuhhZ
	GH1Fyq842MptPwT2Dz1v+krQxDC3xq0mVBA7b78FkQBrTtd1U6Rjb7a8+jeXaQ==
X-Google-Smtp-Source: AGHT+IFa8r1jmAE3TF87p+ZjYjOxHmi2FAw+CssDTLHycGO9qMsOeroqMfRmi0AE4GzvGCr8R3G/6Q==
X-Received: by 2002:a17:902:dad1:b0:1e3:e1fe:d43e with SMTP id q17-20020a170902dad100b001e3e1fed43emr6535plx.11.1712695502499;
        Tue, 09 Apr 2024 13:45:02 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id e10-20020a170902f1ca00b001e2a7ed52d0sm9389391plc.239.2024.04.09.13.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 13:45:01 -0700 (PDT)
Date: Tue, 9 Apr 2024 13:44:58 -0700
From: William McVicker <willmcvicker@google.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Peter Wang <peter.wang@mediatek.com>,
	Stanley Jhu <chu.stanley@gmail.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-scsi@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] scsi: ufs: mediatek: fix module autoloading
Message-ID: <ZhWoytLROIi6GP7s@google.com>
References: <20240409203954.80484-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409203954.80484-1-krzysztof.kozlowski@linaro.org>

On 04/09/2024, Krzysztof Kozlowski wrote:
> Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
> based on the alias from of_device_id table.
> 
> Cc: Will McVicker <willmcvicker@google.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Will McVicker <willmcvicker@google.com>

Thanks,
Will

