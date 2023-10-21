Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E95F7D1C83
	for <lists+linux-scsi@lfdr.de>; Sat, 21 Oct 2023 12:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjJUKVz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 21 Oct 2023 06:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjJUKVU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 21 Oct 2023 06:21:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B5D1719
        for <linux-scsi@vger.kernel.org>; Sat, 21 Oct 2023 03:21:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE64C433CA;
        Sat, 21 Oct 2023 10:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697883664;
        bh=+vlLaqQ2BBzx9ryI1xZX9arCzkip1JQTiNLoh3Yh4JM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J6zqJGJiBySInEO/RGLBztSJX9W4JdUZwNRjRLGuF0VJpu9meTPbR8J+hwHXioryM
         VyHYxbnHUWZxiFXBFofuCfhnFwNpXumghqM9l1umHPcb8m6EuaAalTML8kovqsmP32
         0nmzo5vNQdRu5UIJ1ums7FqlKFob/bbIs6y2NtLk=
Date:   Sat, 21 Oct 2023 12:21:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Milan Broz <gmazyland@gmail.com>
Cc:     linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-scsi@vger.kernel.org, stern@rowland.harvard.edu,
        oneukum@suse.com
Subject: Re: [PATCH 3/7] usb-storage: use fflags index only in usb-storage
 driver
Message-ID: <2023102125-lived-clause-66ad@gregkh>
References: <20231006125445.122380-1-gmazyland@gmail.com>
 <20231016072604.40179-1-gmazyland@gmail.com>
 <20231016072604.40179-4-gmazyland@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016072604.40179-4-gmazyland@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Oct 16, 2023 at 09:26:00AM +0200, Milan Broz wrote:
> This patch adds a parameter to use driver_info translation function
> (which will be defined in the following patch).
> 
> Only USB storage driver will use it, as other drivers do not need
> more than 32-bit quirk flags.

Then this really should be renamed to be something else.

Having a parameter be "0" means we have to go and look up the function
and see what it does and why everyone is passing 0 to it.

Make a "wrapper" function, and rename it to be something sane that does
not need the extra option, and then for the one place you do need it,
use a different function name and then both call the real function.

Does that makes sense?

thanks,

greg k-h
