Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C78C7E0FD7
	for <lists+linux-scsi@lfdr.de>; Sat,  4 Nov 2023 15:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjKDOMx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 4 Nov 2023 10:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjKDOMw (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 4 Nov 2023 10:12:52 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 3709D191
        for <linux-scsi@vger.kernel.org>; Sat,  4 Nov 2023 07:12:48 -0700 (PDT)
Received: (qmail 886183 invoked by uid 1000); 4 Nov 2023 10:12:48 -0400
Date:   Sat, 4 Nov 2023 10:12:48 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Milan Broz <gmazyland@gmail.com>
Cc:     linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-scsi@vger.kernel.org, gregkh@linuxfoundation.org,
        oneukum@suse.com
Subject: Re: [PATCH v5] usb-storage,uas: use host helper to generate driver
 info
Message-ID: <537f0db7-84b3-4f01-a4e5-49164878d7a9@rowland.harvard.edu>
References: <20231028174145.691523-1-gmazyland@gmail.com>
 <20231103201709.124372-1-gmazyland@gmail.com>
 <d26c884e-3505-436f-9a76-ec701fb5e2bb@rowland.harvard.edu>
 <b8fd6e0b-8164-4992-8124-135744430b9c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8fd6e0b-8164-4992-8124-135744430b9c@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, Nov 04, 2023 at 09:01:44AM +0100, Milan Broz wrote:
> Thanks.
> 
> Unfortunately, the build rules, I removed in this version, are needed, see
> https://lore.kernel.org/oe-kbuild-all/202311041507.AOYwj5tK-lkp@intel.com/

Bizarre.  I wonder why it worked on my system but not in the test build.  
Maybe because I wasn't starting from a clean slate but instead from one 
where old versions of the object files already existed.

> I'll keep fixed version in my branch on kernel.org for a day and once
> there are no such bot reports, new version v6 appears in the list.

Okay.

Alan Stern
