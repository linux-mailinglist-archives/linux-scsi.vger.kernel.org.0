Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F25FD11F032
	for <lists+linux-scsi@lfdr.de>; Sat, 14 Dec 2019 05:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfLNEaa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 13 Dec 2019 23:30:30 -0500
Received: from delivery.mailspamprotection.com ([108.178.24.172]:53729 "EHLO
        delivery.mailspamprotection.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726334AbfLNEaa (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 13 Dec 2019 23:30:30 -0500
X-Greylist: delayed 1979 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Dec 2019 23:30:29 EST
Received: from ns1.sgp65.siteground.asia ([77.104.150.195] helo=sgp65.siteground.asia)
        by se3.mailspamprotection.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <fantasie@fantasiechocolate.com>)
        id 1ifxrQ-0000q1-OW; Fri, 13 Dec 2019 21:12:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fantasiechocolate.com; s=default; h=Reply-To:Date:From:To:Subject:
        Content-Description:Content-Transfer-Encoding:MIME-Version:Content-Type:
        Sender:Message-ID:Cc:Content-ID:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=G9LTS5QPxJ/s89LVw4V0N76a9Lg4GJG1FaRG84gTZKM=; b=iye+3iz+tTGMsFiHtVKl1YNuZ
        ucjTp1KH5BUudS9z5ly5Mt450ORFH1+qgCtSjFst6iJK+xd5BIgqGtuHDKzUl+1RZ5IgBwxMtH9EK
        Lpyh5xbM0nlLSA8wH9YrYt6yEK3x7T7qbvuoKweQ5fOk2sQ7v2RGCyl84z58NZiT5L8qGVYtbvB8g
        fgNLtdsszYKG7zWg5FBwxem3+b6K87kFhBDC58hZmT8uShpouocmrJvcUkSReQ1pgluEyz+6NyLHA
        bef0tLIDFZlKsJnHobJ/ItUngaKlHAxkU/UicU8jWvOuD/+/F8EC8cq48N2tqU1gvW2L1KiacWQPE
        /9n3z5Pcw==;
Received: from [41.215.171.102] (port=57237 helo=[192.168.1.2])
        by sgp65.siteground.asia with esmtpa (Exim 4.90devstart-1178-b07e68e5-XX)
        (envelope-from <fantasie@fantasiechocolate.com>)
        id 1ifxWD-0001M6-QZ; Sat, 14 Dec 2019 10:50:58 +0800
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Hello
To:     Recipients <fantasie@fantasiechocolate.com>
From:   fantasie@fantasiechocolate.com
Date:   Fri, 13 Dec 2019 21:50:30 -0500
Reply-To: jackharg231@gmail.com
Message-ID: <E1ifxrQ-0000q1-OW@se3.mailspamprotection.com>
X-Originating-IP: 77.104.150.195
X-SpamExperts-Domain: sgp65.siteground.asia
X-SpamExperts-Username: 77.104.150.195
Authentication-Results: mailspamprotection.com; auth=pass smtp.auth=77.104.150.195@sgp65.siteground.asia
X-SpamExperts-Outgoing-Class: unsure
X-SpamExperts-Outgoing-Evidence: Combined (0.60)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0fi3oD8HEy9ysrsB6Ile+oipSDasLI4SayDByyq9LIhVvIOQ/BkreIJt
 pJikbcIs0kTNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3KduaafvbgG+Io20dOws7uxquy
 8HwVkO17r/7FifbOclsG+1ls7IfY0t6yqfWxTgq9lF2PogyrEWW33pyZ2J35ejUT9RUtu82CIFNv
 cQ2tm5FWJ4KoFob+Ik2D7UV0TE1kAeBLi9TmkSGzVF7gj79q41ATKKOvrV27YkiE2Ud5IbiEzBID
 P1n0XxiFVnXvKRDUwy/qbXXxUtiy6lVUGYuo6Kc80rPrS2q1GFdq5NuioxAlwhS7vEDP48hs3a8c
 wvVyIvMYfGLpvS3jbAVzM/Yd66U5QEG7FriuQT6zOFkNV702wBSrBay58X02UkNHMOYWz20nyvkA
 BBOF7CIJ0P4NEa0MVfWO89fBHFjAjqGF5YGEXgVxv9Klp88SJAPxog2IqEL+fpLmxSuv0eUZbv0P
 giI3bZrStTuaivrSsTp6gKkHOQxUjrO1XWlwsRo8LPrO02hVjN28X/iCmueUgiyhVzqNEbCT5lFZ
 aLyV6ehRUGzOW0IRPXlDEL949U2nBTnhwzFzJzX3pBNfVisdwDuR9rg4VFF5hTsNkQLnL6NOV/Iv
 BNK2au+oBdNWpgTxpgQ61hAgEi9B8qu60I/Na+X8q84eEQa0tciHYXPDgLhYsz9pkQTcnvqPqs09
 qKNL6abvfDBczjLFed40qruimRJGkZQ/+oaMObhOc6N0/UwKUfKZQo4viV6DZHwf9zdpEi6QYb+5
 4UzuQE973EVJKYt+XDe0mKpYRjQ8byeNri1ricQWo1wwegDTuSnf/0UA5oP4zXbN3FvA3JMphioV
 KyKxQ+zJ7bkJFtzBESTIzVqakfivvu/ID51BvCO1YZID2TbKEYqkLOLZv2WEroMh5jNfbHwxMu8e
 AQAPWHdgwUkydxaceXZNG0EUbELA0uv9YhdOwF43sCaXstEuNOECO0tnJwnalYy8O6Q05bHAbVVv
 fYETknyProQhJAnFm9SejeALBxg4lBnxsuI7WPdQxMr/PrvwjRxaZAd2wJZIDBh7wCrS8rKp0Vif
 CodAlCkRoHLcvyKXKixi6i6IqAugTKe4Hcqoax47JpuXFo3ZUsaCGkYgWv+5Dvi6jZTOEtXNGFNA
 YN4ThektAhJU8gMjEyggqtviSbgr1aNP2Wf2y4G+9f+0iY8zeXvFRZRI5qkeK871FyrtVW4KaRSU
 RqFyxA+5h6S9PU+X5dzR/uMRJ1TxC8bltRI8KgDKjKewKzOknFKgM/Ri4pnmq4UuVF1EVN4nuk0X
 ZjECm5LJWc9ZiWVRjoItoXcRDxEiiXhmVFyL7v/68tguCv3SzCuyjU4x4V9B7lNbuw/fp9Ndj0+x
 QrINZM7n0/NyKnZSfcMqYPZon7eUYAqPgS/pPg/UjICGCzoz+FmXdpN1W727lnG3UnZUiJSm6GmH
 SkoSjCBx1DE3zV+OSNl+KnBlQlbX0LDJaTAIkVFF7vCF5HBlU5mxBFeVjQy3g5BZzNS0lvBIrVIi
 3K7nLijGhgqy82Gfc7IRFd6+75JjPEZQIfxGNbtgCe/G2iUBI5jgy5Cky5wadhWPTF2+W3C1tl/T
 81CHYryhRFAy/TVI/K95WsACB3TjwX6+ZntI4r5keeQor5E+H5iZ2zirnBsNbiuwty3Zvm32lHIv
 tUfVaxoYA7Jgbd9maoZfKEyJnqGlvO9uIvxqwos+wMOiKRfEYaxQgGPvexbZaIpnseB6S176HZWN
 ha0sVbL2pdQX5fZ6s8j+X2bsnQfn2F9U
X-Report-Abuse-To: spam@quarantine1.mailspamprotection.com
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Are you available?


Regards
Jack Hargreaves
Broker/Financial consortium
