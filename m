Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC734265496
	for <lists+linux-scsi@lfdr.de>; Thu, 10 Sep 2020 23:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbgIJV6s convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Thu, 10 Sep 2020 17:58:48 -0400
Received: from mail2.bemta23.messagelabs.com ([67.219.246.9]:38631 "EHLO
        mail2.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730312AbgIJLNc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 10 Sep 2020 07:13:32 -0400
Received: from [100.112.0.190] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.us-east-1.aws.symcld.net id DF/7F-59917-35A0A5F5; Thu, 10 Sep 2020 11:13:23 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+JIrShJLcpLzFFi42K5lR4TrBvMFRV
  v8OuunsXUE+9YLfpbfrBbTDx2g9Hiz5Wv7BYvXy1htWh7eo3F4sTzp6wW7XteM1ucft7ManF1
  zxV2i9blL1ksuq/vYLO4uWAWm8WO7feZLf6+X8xm0ffmObPF2olt7BaXP95htJizvYnVYsOnE
  +wOIh5v7qxm8bi/eyW7x+QnG5k8+rYdZvf48noWk8fSuavZPXbOusvu8eFjnMei80dZPGZ9Wc
  /s8b1HzuPzJjmP28+2sXhMuPGYMYAvijUzLym/IoE1o3PGQbaC1+wVZ+Z3sTYwPmLrYuTiEBJ
  Ywijxe/1B1i5GTg5mAT2JG1OnsIHYvAKCEidnPmGBiGtLLFv4mrmLkQPIVpP42lUCEhYW4Jbo
  PvGXHSQsIsAn8fF+AEiYTUBUYtumE8wgNouAqsSMjitgthCQffvdEkYQW0LAXmLp+wtQtqTEk
  9uTGSG2ukv0b5sLtklIgF9iwu2qCYx8s5DcNgvJbbOQ3DYL4bYFjCyrGM2SijLTM0pyEzNzdA
  0NDHQNDY10jXQNjYz1Eqt0k/RKi3VTE4tLdA31EsuL9Yorc5NzUvTyUks2MQKjOqWAqXoH449
  XH/QOMUpyMCmJ8srcjowX4kvKT6nMSCzOiC8qzUktPsSox8EhcOHsw0+MAlc+fGpikmLJy89L
  VZLgPXwXqFqwKDU9tSItMweYhGAaJDh4lER4ee4BpXmLCxJzizPTIVKnGL05Nh6dt4iZYzuYP
  AYm+9csBpIvdy4Bkod3A0khsA1S4rxOIBsEQEZklObBLYAl00uMslLCvIwMDAxCPAWpRbmZJa
  jyrxjFORiVhHnlQabwZOaVwN3xCuhEJqATG+XBTixJREhJNTA1BcpzHAr7FDz3XPTDX5s+emR
  Lvdi9u16y4hrLspikKZdnigR+rVuy3mBTTpTXodvSCT/3fKoJjxQPkLay1y/cPfds2r4dE1Qe
  plivt844NcXq4Ymbkw1bN/gx5DOuiGataBSXu/DSwPvD/8A1ruWvLkf2nO72nyiTGNZl29Cft
  uppykpJ1c1XY2aHrNE/bMIRz/maT+fdDIUNu39lVE58NkdVMCrwWejpvc6nDmrvuaWvH6TFtz
  HmROW8/p5v93ZK8mjbel90savw7b2zKf2+jGTtnbnfY276qJ31fNbO1OExN0mpuCXtylMztbl
  lbS6Lr7xnDb75Z/acoJJT38PdzHQy33ywyqutOX/pL68SS3FGoqEWc1FxIgA9vgQWIQQAAA==
X-Msg-Ref: server-30.tower-385.messagelabs.com!1599736362!509009!51
X-Originating-IP: [218.103.92.83]
X-SYMC-ESS-Client-Auth: outbound-route-from=fail
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8940 invoked from network); 10 Sep 2020 11:13:23 -0000
Received: from 083.92.103.218.static.netvigator.com (HELO fksex.fkdomain.local) (218.103.92.83)
  by server-30.tower-385.messagelabs.com with SMTP; 10 Sep 2020 11:13:23 -0000
Received: from [172.20.10.4] (102.80.141.101) by fksex.fkdomain.local
 (192.168.1.9) with Microsoft SMTP Server (TLS) id 8.2.255.0; Thu, 10 Sep 2020
 19:13:10 +0800
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Description: Mail message body
Subject: Re
To:     Recipients@vger.kernel.org
From:   Stefano@vger.kernel.org, Pessina@vger.kernel.org
Date:   Thu, 10 Sep 2020 04:12:51 -0700
Reply-To: stefanopessina679@yahoo.com
X-Antivirus: Avast (VPS 200910-0, 09/09/2020), Outbound message
X-Antivirus-Status: Clean
Message-ID: <49e43c78-1ed0-4d29-99da-a50816c75973@fksex.fkdomain.local>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hallo,

Ich bin Stefano Pessina, ein italienischer Wirtschaftsmagnat, Investor und Philanthrop. der stellvertretende Vorsitzende, Chief Executive Officer (CEO) und der größte Einzelaktionär der Walgreens Boots Alliance. ich gab
25 Prozent meines persönlichen Vermögens für wohltätige Zwecke wegbringen. Und ich habe auch zugesagt, den Rest von 25% in diesem Jahr 2020 wegen des Herzschmerzes von Covid-19 an Einzelpersonen zu verschenken. Ich habe beschlossen, Ihnen 950.000,00 USD (neunhundertfünfzigtausend Dollar) zu spenden. Wenn Sie an meiner Spende interessiert sind, kontaktieren Sie mich für weitere Informationen. über meine E-Mail an (stefanopessina679@yahoo.com)

Sie können auch mehr über mich über den unten stehenden Link lesen

https://en.wikipedia.org/wiki/Stefano_Pessina

Herzlicher Gruss
CEO Walgreens Boots Alliance
Stefano Pessina

-- 
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus

