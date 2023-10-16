Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2487CB166
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Oct 2023 19:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbjJPReC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 16 Oct 2023 13:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPReB (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 16 Oct 2023 13:34:01 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 82534A2
        for <linux-scsi@vger.kernel.org>; Mon, 16 Oct 2023 10:33:59 -0700 (PDT)
Received: (qmail 150486 invoked by uid 1000); 16 Oct 2023 13:33:57 -0400
Date:   Mon, 16 Oct 2023 13:33:57 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Milan Broz <gmazyland@gmail.com>
Cc:     linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-scsi@vger.kernel.org, gregkh@linuxfoundation.org,
        oneukum@suse.com
Subject: Re: [PATCH 0/7] usb-storage,uas: Support OPAL commands on USB
 attached devices.
Message-ID: <76575d36-15d3-491b-944e-71253907cfac@rowland.harvard.edu>
References: <20231006125445.122380-1-gmazyland@gmail.com>
 <20231016072604.40179-1-gmazyland@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016072604.40179-1-gmazyland@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Oct 16, 2023 at 09:25:57AM +0200, Milan Broz wrote:
> This patchset adds support for OPAL commands (self-encrypted drives)
> through USB-attached storage (usb-storage and UAS drivers).

This is version 2 of the proposed patch set, but you didn't include the 
version number in the email Subject: lines and you didn't include the 
summary of differences from v1 below the "---" lines of the various 
patches.

Patches 5, 6, and 7 look okay.  You can add my Reviewed-by: to each of 
them.

I've got some additional comments on patch 4 (in a separate email).

Alan Stern
