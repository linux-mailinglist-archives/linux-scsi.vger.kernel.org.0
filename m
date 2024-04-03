Return-Path: <linux-scsi+bounces-4039-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD220896EBA
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Apr 2024 14:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB251C22666
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Apr 2024 12:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2297C145FF8;
	Wed,  3 Apr 2024 12:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ecKGVZdU"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91531145B2A
	for <linux-scsi@vger.kernel.org>; Wed,  3 Apr 2024 12:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712146337; cv=none; b=r3GCqXpRNt8cNZp4Avwv0faY5IEhKRPB+D/+a2HCoyGFQq40jOG8C66CZS/5H2e2A5hypAs8YjshxU0Ki5d/jJkLOp/OUK3GLUNogxdgzlwmkrFhwRI+CQNRuHS4nlSgNtepVdnJPW/3XjsIDJFLzX4s9VPwBfSfXJTuSHqO5TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712146337; c=relaxed/simple;
	bh=brj4KkxiuzB/cTaKYABW0xgl0MAd+mDFIIil3DRUwDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsARC/SVe+kUeYDHh61n3ndJ/mhS9y8xFlNr9s+CnZQA8ArUvpC86XczCYmmrl6eceDgD9+D+2YFVeL9comJKcRBYUB1sWf8IcqOcxh5YgYDakmH4EtnnHu7MZRFmQbWzI0R/fKxffOia2igMcj9QPAwTh+ZzRGT5Daw0pPIBug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ecKGVZdU; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e0d82c529fso53653465ad.2
        for <linux-scsi@vger.kernel.org>; Wed, 03 Apr 2024 05:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712146336; x=1712751136; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BruioLBkFU/4Gr8BIJ48KpNZhiGvLxDKNkifr5Fva6A=;
        b=ecKGVZdU8bhNPOpAvLxziCRXwbUZUX8cMZsuid5A/T/ooIhW/535QZ/1NlopqlyS9C
         dCx4gdliNUeIHps69L+yl7pi+6fMraB0ek0+OmtX5Otla7doi6uEyKpBTNSTi63f5dA8
         docrsXAbau2BcyALZwP1Bkj6DExFqjBZ06elIc4qLhnBO/iUXGe0MpfPFdJndxKsaRiQ
         AZQYeFBp4BJMaAQFx1WUvW0Vzhjym5bZ26pxkBZmPBzdUjPzQimi+Uoq0X0HOLTX2ehr
         qDui1+k6p5UTfYpQSYT0YvH+xX91jIqVfG4t47NqubEqn8XK6PFv6yhFnDGj42QoGCHb
         lYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712146336; x=1712751136;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BruioLBkFU/4Gr8BIJ48KpNZhiGvLxDKNkifr5Fva6A=;
        b=u5ENKV6WIXZh2rOKHAYycEi7/t6910BP+hq3K8AZjw5LtK0Y4eDbwT6YYfUueLhu7D
         u8hAX1DrL2TSsr70BnxmjWeNrzSQlcDGpG59kP1wX+C5WFtNxKzk9V0aTDRG/xN7MkWH
         jOP7NG9rMrnN48qU6P6cZepzUm+mgs4Yek450hhnk6wxLxWErZANcPMu/RHRWdRiAvKN
         18vMUyJqDpkttdcHjqfRNI31qwsajXZnVqVXBgg3T70GnhzIxbD0CNR3guvQwKQMLnUx
         A9pwhZyNKb9HAmVUxBQAXNP3Z63uCCvoR0cvvF82P0jX2b8ztLeSFDUVVAJ9OMgAP0A8
         qCqg==
X-Forwarded-Encrypted: i=1; AJvYcCWdav70IKNdmuYtCzDSaN6rVq/zemoF7saOBS8QzErPlF9QITVMjmPkQMRhTH/mgBOInRLXMutexZNMdeMOj0QWxpdrh+btC93DUw==
X-Gm-Message-State: AOJu0YzVj5zTfC+w3/H/XXI+5fvegys8uElePK5SQUHD9Lb554YTEOMJ
	5GVSRUBg/x1WX9f/eXBpxNnTW9PwzSO/C2hFGMcdu3/Q0+CRVe2ddkp1F7VJuQ==
X-Google-Smtp-Source: AGHT+IG9NG4VxPu4A8bz2c/Sxzuq1eBAlbG1/HgvyTLPbTBK7p4H9R0/kt20ykZuifHv/l0Kuczj7A==
X-Received: by 2002:a17:902:784d:b0:1e2:7aaf:65bc with SMTP id e13-20020a170902784d00b001e27aaf65bcmr3297593pln.34.1712146335487;
        Wed, 03 Apr 2024 05:12:15 -0700 (PDT)
Received: from thinkpad ([103.28.246.48])
        by smtp.gmail.com with ESMTPSA id j8-20020a170902da8800b001e205884ac6sm13072185plx.20.2024.04.03.05.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 05:12:15 -0700 (PDT)
Date: Wed, 3 Apr 2024 17:42:10 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [PATCH] scsi: ufs: qcom: Add missing interconnect bandwidth
 values for Gear 5
Message-ID: <20240403121210.GJ25309@thinkpad>
References: <20240401-ufs-icc-fix-v1-1-3bac41bdfa7a@linaro.org>
 <e2206445-d560-43ad-8fb1-f0b4967493f2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2206445-d560-43ad-8fb1-f0b4967493f2@linaro.org>

On Tue, Apr 02, 2024 at 04:48:40PM +0200, Konrad Dybcio wrote:
> On 1.04.2024 5:09 PM, Manivannan Sadhasivam wrote:
> > These entries are necessary to scale the interconnect bandwidth while
> > operating in Gear 5.
> > 
> > Cc: Amit Pundir <amit.pundir@linaro.org>
> > Fixes: 03ce80a1bb86 ("scsi: ufs: qcom: Add support for scaling interconnects")
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> 
> Skimming through the code, could ufs_qcom_get_bw_table use a
> WARN_ON_ONCE(nullcheck)?
> 
> FWIW, this change looks sane (without checking the numbers)
> 

This really makes sense. Will add a patch in v2.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

