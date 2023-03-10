Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D943F6B3767
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Mar 2023 08:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjCJHcn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 10 Mar 2023 02:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjCJHcO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 10 Mar 2023 02:32:14 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E2D10B1D3
        for <linux-scsi@vger.kernel.org>; Thu,  9 Mar 2023 23:32:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C438DCE25D1
        for <linux-scsi@vger.kernel.org>; Fri, 10 Mar 2023 07:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91ED7C433D2;
        Fri, 10 Mar 2023 07:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678433526;
        bh=foGSirorxlIF2n01S1rkWCkz9088w6vCHQqv2fWvV/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PYeCDiLjJ6za8JwPJaPq6G6CLrZhrSJNVJ6QvhVgcz5VA6R6gyBYZ+dBmDyWcXEVR
         bgHIpZ0oyY1qrnxhNtAb4iVksPos87w/NKdbK9+m44pQZiHxwgYTl37R0NFxmW+bA5
         fYr1YOJ8vHQsFo5hMuQwT8lV+JV27W2w5rT0cKS0=
Date:   Fri, 10 Mar 2023 08:32:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        Charlie Sands <sandsch@northvilleschools.net>
Subject: Re: [PATCH v2 78/82] scsi: rts5208: Declare SCSI host template const
Message-ID: <ZArc9M8olXWJ625o@kroah.com>
References: <20230309192614.2240602-1-bvanassche@acm.org>
 <20230309192614.2240602-79-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309192614.2240602-79-bvanassche@acm.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Mar 09, 2023 at 11:26:10AM -0800, Bart Van Assche wrote:
> Make it explicit that the SCSI host template is not modified.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
