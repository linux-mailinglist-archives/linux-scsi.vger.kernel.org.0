Return-Path: <linux-scsi+bounces-2233-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B98584A33D
	for <lists+linux-scsi@lfdr.de>; Mon,  5 Feb 2024 20:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07FD1F22C93
	for <lists+linux-scsi@lfdr.de>; Mon,  5 Feb 2024 19:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10405A7A9;
	Mon,  5 Feb 2024 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PSsFQsEY"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3AB5A4D4;
	Mon,  5 Feb 2024 19:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159787; cv=none; b=J88s4NdeCxsfK3gY2aqT+Dwc+diKN+UTS2Q0LjOLDDZjTU8R1E3AXV6ZPKJI2jgW4nt0B3u+0/62L5rEdNA88VBGzO4Fsdw9IyAiOdWXrpev9kILRmTN20LEImskDDAxtOzaidi6+vZCp3xWjK5ZAzijUyVewN3P2mQ3xKz1M7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159787; c=relaxed/simple;
	bh=mMsgTGDgH2EjVae8ropBazsxehXluLS59BuMK2VgrxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOID/J9uT90nWdDHwO3YfHLCxdvBEmJH4ANvaKiBlbejzigDpTUhcgf5dVjUgg4nGZY3NYRHPsp1oMo9HbsP/13uQOCz8Uhf/Retq/ZW7jn/pjdSBdUaGsSQcTHSc830h50N1Md4w2Ky+8qwUM4n6hSX5b0xaK3kUmTULC+U2t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PSsFQsEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799CBC433F1;
	Mon,  5 Feb 2024 19:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159786;
	bh=mMsgTGDgH2EjVae8ropBazsxehXluLS59BuMK2VgrxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PSsFQsEYJxuwAl0PIJL8vA/Kwn++t7XhSHa5Df43Yljuiglbeh+qvXlAO0F6+EIP/
	 QVs+zw+RJMnU8+Zu3t2v37i1beW9ZmPEy5j0MKuboQpg8f2lKh2lAConq4R2kvs2HJ
	 XyC/Di6SaJSFnV6Izo/kWYObuLtR9K00ZztBGPQs=
Date: Mon, 5 Feb 2024 04:46:40 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: tcm_loop: make tcm_loop_lld_bus const
Message-ID: <2024020535-straining-marital-0334@gregkh>
References: <20240204-bus_cleanup-target-v1-1-96106936c4ab@marliere.net>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-target-v1-1-96106936c4ab@marliere.net>

On Sun, Feb 04, 2024 at 05:48:26PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the tcm_loop_lld_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

