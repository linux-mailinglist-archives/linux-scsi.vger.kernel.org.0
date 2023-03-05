Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06DD6AB2A2
	for <lists+linux-scsi@lfdr.de>; Sun,  5 Mar 2023 22:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjCEVmH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 5 Mar 2023 16:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCEVmG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 5 Mar 2023 16:42:06 -0500
X-Greylist: delayed 581 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Mar 2023 13:42:03 PST
Received: from bamako.nerim.net (bamako.nerim.net [178.132.17.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D43259FB
        for <linux-scsi@vger.kernel.org>; Sun,  5 Mar 2023 13:42:02 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bamako.nerim.net (Postfix) with ESMTP id 7541D39DE6B;
        Sun,  5 Mar 2023 22:32:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at nerim.net
Received: from bamako.nerim.net ([127.0.0.1])
        by localhost (bamako.nerim.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yKbQJFbQ7rnK; Sun,  5 Mar 2023 22:31:31 +0100 (CET)
Received: from [192.168.0.252] (plouf.fr.eu.org [213.41.155.166])
        by bamako.nerim.net (Postfix) with ESMTP id 5536939DC7C;
        Sun,  5 Mar 2023 22:31:30 +0100 (CET)
Message-ID: <5b30b2b2-c47a-da1e-8106-025c914faebd@plouf.fr.eu.org>
Date:   Sun, 5 Mar 2023 22:31:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Hannes Reinecke <hare@suse.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>
From:   Pascal Hambourg <pascal@plouf.fr.eu.org>
Subject: [Bug report] scsi: advansys: module init fails if ISA_BUS_API is not
 set
Organization: Plouf !
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

(If you reply from the mailing list, please Cc me, I am not subscribed)

Dear kernel maintainers and developers,

With a kernel configuration resulting in ISA_BUS_API being unset (as in 
Debian amd64 kernels), loading the advansys module fails:

# modprobe advansys
modprobe: ERROR: could not insert 'advansys': No such device

advansys_init() calls isa_register_driver() which returns -ENODEV when 
CONFIG_ISA_BUS_API is not defined.

Commit 9b4c8eaa68d0ce85be4ae06cbbd158c53f66fe4f "advansys: remove ISA 
support" in Linux 5.13 did not remove the call to isa_register_driver() 
for the VLB driver, so the issue remains.

What is the proper way to fix this ?

a) In drivers/scsi/Kconfig
add "select ISA_BUS_API" to SCSI_ADVANSYS dependencies.

b) In include/linux/isa.h
make isa_register_driver() return 0 instead of -ENODEV if ISA_BUS_API is 
unset.
Rationale: eisa_register_driver() and pci_register_driver() return 0 if 
EISA or PCI respectively is unset.

c) In drivers/scsi/advansys.c
make advansys_init() return failure only if all 
{isa,eisa,pci}_register_driver() calls return failure.

d) In drivers/scsi/advansys.c
remove VLB support in kernel >= 5.13.
Rationale: VLB is an extension of the ISA bus, can it work without ISA 
support ?
Besides, I believe that VLB disappeared before ISA, it was specific to 
i486 motherboards while ISA lasted at least up to Pentium III motherboards.

e) In drivers/scsi/advansys.c
conditionally build ISA/VLB support only if ISA_BUS_API is set.

f) other ?
